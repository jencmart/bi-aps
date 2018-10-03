#include <iostream>
#include <sstream>
#include <iterator>
#include <vector>
#include <map>
#include <bitset>

using namespace std;

class UnknownOperand
{
    string m_op;

public:
    explicit UnknownOperand( string & op) : m_op(op) {}

    friend ostream &operator<<(ostream &os, const UnknownOperand &operand) {
        os << "Error : '" << operand.m_op << "'" << endl;
        return os;
    }
};


char getHexCharacter(const string & str)
{
    if(str == "1111") return 'F';
    else if(str == "1110") return 'E';
    else if(str == "1101") return 'D';
    else if(str == "1100") return 'C';
    else if(str == "1011") return 'B';
    else if(str == "1010") return 'A';
    else if(str == "1001") return '9';
    else if(str == "1000") return '8';
    else if(str == "0111") return '7';
    else if(str == "0110") return '6';
    else if(str == "0101") return '5';
    else if(str == "0100") return '4';
    else if(str == "0011") return '3';
    else if(str == "0010") return '2';
    else if(str == "0001") return '1';
    else if(str == "0000") return '0';

    else if(str == "111") return '7';
    else if(str == "110") return '6';
    else if(str == "101") return '5';
    else if(str == "100") return '4';
    else if(str == "011") return '3';
    else if(str == "010") return '2';
    else if(str == "001") return '1';
    else if(str == "000") return '0';

    else if(str == "11") return '3';
    else if(str == "10") return '2';
    else if(str == "01") return '1';
    else if(str == "00") return '0';
    else if(str == "1" ) return '1';
    else return '0';

}


string byteFromRegNum( string s)
{
    s.erase(0,1);
    auto reg =(unsigned) stoi(s);
    return bitset< 5 >( reg ).to_string();
}

void parse(vector<string> & tokens, vector<string> & dataToWrite, map<string, string> & defines, map<string, int> & addr, int instrPos )
{
    string binaryString;

    /// s-t-d style instructions
    if(tokens[0] == "add" ||
            tokens[0] == "sub" ||
            tokens[0] == "and" ||
            tokens[0] == "or" ||
            tokens[0] == "slt"  ||
            tokens[0] == "addu.qb" ||
            tokens[0] == "addu_s.qb"
           )
    {
        if(tokens[0] == "addu.qb" || tokens[0] == "addu_s.qb")
            binaryString += "011111";
        else
            binaryString += "000000";

        string d = tokens[1];
        string s = tokens[2];
        string t = tokens[3];

        // save s
        if(s[0] == '$')
            binaryString += byteFromRegNum(s);
        else
            binaryString += byteFromRegNum( defines.find(s)->second);

        // save t
        if(t[0] == '$')
            binaryString += byteFromRegNum(t);
        else
            binaryString += byteFromRegNum( defines.find(t)->second);

        // save d
        if(d[0] == '$')
            binaryString += byteFromRegNum(d);

        //save rest...
        else
            binaryString += byteFromRegNum( defines.find(d)->second);

        if     (tokens[0] == "add")
            binaryString += "00000100000";
        else if(tokens[0] == "sub")
            binaryString += "00000100010";
        else if(tokens[0] == "and")
            binaryString += "00000100100";
        else if(tokens[0] == "or")
            binaryString += "00000100101";
        else if(tokens[0] == "slt")
            binaryString += "00000101010";
        else if(tokens[0] == "addu.qb")
            binaryString += "00000010000";
        else if(tokens[0] == "addu_s.qb")
            binaryString += "00100010000";
    }

    else if ( tokens[0] == "sllv" ||
              tokens[0] == "srlv" ||
              tokens[0] == "srav")
    {
        binaryString += "000000";

        string d = tokens[1];
        string t = tokens[2];
        string s = tokens[3];

        // save s
        if(s[0] == '$')
            binaryString += byteFromRegNum(s);
        else
            binaryString += byteFromRegNum( defines.find(s)->second);

        // save t
        if(t[0] == '$')
            binaryString += byteFromRegNum(t);
        else
            binaryString += byteFromRegNum( defines.find(t)->second);

        // save d
        if(d[0] == '$')
            binaryString += byteFromRegNum(d);

            //save rest...
        else
            binaryString += byteFromRegNum( defines.find(d)->second);

        if(tokens[0] == "sllv")
            binaryString += "00000000100";
        else if(tokens[0] == "srlv")
            binaryString += "00000000110";
        else if(tokens[0] == "srav")
            binaryString += "00000000111";
    }


    else if(tokens[0] == "addi")
    {
        // save infix
        binaryString += "001000";

        string t = tokens[1];
        string s = tokens[2]; // ano ok
        string imm = tokens[3];

        // save s
        if(s[0] == '$')
            binaryString += byteFromRegNum(s);
        else
            binaryString += byteFromRegNum( defines.find(s)->second);

        // save t
        if(t[0] == '$')
            binaryString += byteFromRegNum(t);
        else
            binaryString += byteFromRegNum( defines.find(t)->second);

        // save imm todo done - muze byt adresa...
        if(  ! isdigit(imm[0]))
            binaryString +=  bitset< 16 >( (unsigned long)addr.find(imm)->second ).to_string();
        else
            binaryString += bitset< 16 >( (unsigned) stoi(imm) ).to_string();
    }


        /// LW SW
    else if(tokens[0] == "lw" || tokens[0] == "sw") // todo - zatim nepotrebuji, ale do lw, sw take muze jit offset jako adr ?
    {
        if(tokens[0] == "lw" )
            binaryString += "100011";
        else
            binaryString += "101011";




        string t = tokens[1];

        string offset;
        string s;

        string tmp = tokens[2];
        //todo
        for(int i = 0 ; i < tokens[2].size() ; ++i)
        {
            if(tokens[2][i] == '(')
            {
                offset = tokens[2].substr(0,i);
                s = tokens[2].substr(i+1, tmp.size() - (i+2));
                break;
            }
        }

        // save s
        if(s[0] == '$')
            binaryString += byteFromRegNum(s);
        else
            binaryString += byteFromRegNum( defines.find(s)->second);

        // save t
        if(t[0] == '$')
            binaryString += byteFromRegNum(t);
        else
            binaryString += byteFromRegNum( defines.find(t)->second);

        // save imm
        binaryString += bitset< 16 >( (unsigned) stoi(offset) ).to_string();
    }

    else if(tokens[0] == "beq")
    {
        binaryString += "000100";

        string s = tokens[1];
        string t = tokens[2];
        string offset = tokens[3];

        // save s
        if(s[0] == '$')
            binaryString += byteFromRegNum(s);
        else
            binaryString += byteFromRegNum( defines.find(s)->second);

        // save t
        if(t[0] == '$')
            binaryString += byteFromRegNum(t);
        else
            binaryString += byteFromRegNum( defines.find(t)->second);

        if(  ! isdigit(offset[0])) // todo done - offset CYHBA
            binaryString +=  bitset< 16 >( (unsigned long)addr.find(offset)->second  - instrPos - 1).to_string();
        else
        // save offset
        binaryString += bitset< 16 >( (unsigned) stoi(offset) ).to_string();
    }

    else if(tokens[0] == "jal")
    {
        binaryString += "000011";

        string target = tokens[1];

        if(  ! isdigit(target[0])) // todo done target - adresa naprimo - ok
            binaryString +=  bitset< 26 >( (unsigned long)addr.find(target)->second  ).to_string(); // NESMI SE NASOBIT 4MA KOKOTE
        else
            binaryString += bitset< 26 >( (unsigned) stoi(target)  ).to_string();
    }

    else if(tokens[0] == "jr")
    {
        binaryString += "000111";

        string s = tokens[1];

        // save s
        if(s[0] == '$')
            binaryString += byteFromRegNum(s);
        else
            binaryString += byteFromRegNum( defines.find(s)->second);

        binaryString += "000000000000000001000";
    }

    else
    {
        throw UnknownOperand(tokens[0]);
    }

    string hexString;
    hexString += getHexCharacter(binaryString.substr (0,4) );
    hexString += getHexCharacter(binaryString.substr (4,4) );
    hexString += getHexCharacter(binaryString.substr (8,4) );
    hexString += getHexCharacter(binaryString.substr (12,4) );
    hexString += getHexCharacter(binaryString.substr (16,4) );
    hexString += getHexCharacter(binaryString.substr (20,4) );
    hexString += getHexCharacter(binaryString.substr (24,4) );
    hexString += getHexCharacter(binaryString.substr (28,4) );

    dataToWrite.emplace_back(hexString);
}

int main()
{
    map<string, string> defines;

    vector<string> dataToWrite;
    map<string, int> addr;


    vector<vector<string>> instructions;

    while(true)
    {
        string str; getline(cin, str);

        if(cin.eof())
            break;

        if(str == "exit")
            break;

        for(auto & c : str) // change commas to spaces
            if(c ==',' )
                c = ' ';

        vector<string> tokens;
        istringstream iss(str);

        copy(istream_iterator<string>(iss), istream_iterator<string>(), back_inserter(tokens));

        if(tokens.empty() || (tokens[0][0] == '/' && tokens[0][1] == '/'  ) || tokens[0][0] == '.' )
            continue;

        else if(tokens[0] == "#define") // define value defined by define
        {
            defines[tokens[1]] = tokens[2];  // {#define s0 $20}
            continue;
        }

        else if(tokens[0].back() == ':') // bude to adresa ;
        {
            tokens[0].erase(tokens[0].size() - 1); // odstran dvojtecku
            addr[tokens[0]] = (int)instructions.size();
        }

        else
        {
            instructions.emplace_back(tokens);
        }
    }


    for(int i = 0 ; i < (int)instructions.size() ; ++i)
    {
        try {
            parse(instructions[i], dataToWrite, defines, addr, i);
        }catch (UnknownOperand & x)
        {
            cout << x;
            return 1;
        }

    }

    for(auto & s : dataToWrite)
    {
        cout << s << endl;
    }

 //   if(dataToWrite.size() < 64)
 //   {
 //       for(int i = (int)dataToWrite.size() ; i < 64 ; ++i)
 //           cout << "00000000" << endl;
 //   }

    return 0;
}

/***
 *
#define t0 $1
addi t0 $0 3
addi $2 $0 5
addi $3 $0 8
add $4 $1 $2
beq $3 $4 5


00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000
00000000

***/