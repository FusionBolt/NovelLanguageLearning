use nom::{IResult, bytes::complete::{tag, take_while_m_n}, combinator::map_res, character::complete::char, sequence::tuple, Or};
use nom::sequence::delimited;
use nom::bytes::complete::is_not;
use nom::branch::alt;
use nom::combinator::opt;
use nom::multi::many0;

fn parse_pair_bracket(input: &str) -> IResult<&str, &str> {
    delimited(char('('), is_not(")"), char(')'))(input)
}

fn parse_alt_keyword(input: &str) -> IResult<&str, &str> {
    alt((tag("trait"), tag("int"), tag("fn")))(input)
}

fn parse_optional(input: &str) -> IResult<&str, Option<&str>> {
    opt(tag("fn"))(input)
}

fn parse_many(input: &str) -> IResult<&str, Vec<&str>> {
    many0(tag("rua"))(input)
}

fn main() {
    println!("nom test");
}

#[cfg(test)]
mod tests {
    use crate::{parse_pair_bracket, parse_alt_keyword, parse_optional, parse_many};

    #[test]
    fn test_many() {
        assert_eq!(parse_many("ruaruarua"), Ok(("", vec!["rua", "rua", "rua"])));
        assert_eq!(parse_many("rua_mol"), Ok(("_mol", vec!["rua"])));
        assert_eq!(parse_many("mol"), Ok(("mol", Vec::new())));
    }

    #[test]
    fn test_optional() {
        assert_eq!(parse_optional("fn"), Ok(("", Some("fn"))));
        assert_eq!(parse_optional("test"), Ok(("test", None)));
    }

    #[test]
    fn test_alt() {
        assert_eq!(parse_alt_keyword("trait"), Ok(("", "trait")));
        assert_eq!(parse_alt_keyword("int"), Ok(("", "int")));
        assert_eq!(parse_alt_keyword("fn"), Ok(("", "fn")));
    }

    #[test]
    fn test_pair_bracket() {
        assert_eq!(parse_pair_bracket("(_test_str)"), Ok(("", "_test_str")));
    }
}