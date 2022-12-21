package com.kook.ezenPJT.command;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.kook.ezenPJT.dao.EzenDao;
import com.kook.ezenPJT.dto.RecipeDto;
import com.kook.ezenPJT.util.Constant;

public class EzenRecipeCommand implements EzenCommand {

	@Override
	public void execute(HttpServletRequest request, Model model) {
		EzenDao edao = Constant.edao;
		//EzenDao edao = (EzenDao)request.getAttribute("dao");
		ArrayList<RecipeDto> dtos = edao.recipeList();
		model.addAttribute("recipeList", dtos);
	}

}
