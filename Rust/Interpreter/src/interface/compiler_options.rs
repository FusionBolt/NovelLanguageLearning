pub struct CompilerOptions
{

}

impl CompilerOptions {
    pub fn new(args: &[String]) -> Result<CompilerOptions, &'static str> {
        Ok(CompilerOptions{ })
    }
}