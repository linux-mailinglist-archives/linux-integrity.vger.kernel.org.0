Return-Path: <linux-integrity+bounces-3165-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D1F933D6D
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jul 2024 15:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB8B41C22C1A
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jul 2024 13:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8381A1802C4;
	Wed, 17 Jul 2024 13:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="Z4OcyPTZ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B1C18004E;
	Wed, 17 Jul 2024 13:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721222068; cv=pass; b=YVvyNmBAUUfSKuJKyYz/QkRv5VhJ2fiH2HftN1WuNuPZoUs6t6B6gENBV3rD8nkQ10TDgXn0hTtQyOrigSW/o95ruBaMDPtMck31b0Swlj+TWC4iAACuWlTNw35ZG7uvyMa5hu+or6yanhFH5hsWs684Nd0TyKHg9wFGFNi2qVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721222068; c=relaxed/simple;
	bh=UhNWj8tbJsA/dIsV0n7TH0YDw2A+cYy/1vuKntGxdpE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=i1joC5CfuNUn78auvojeQvVUfwSwJF9+7mqdsWFmv7H4UbF0P6F/ivxiV05HQKmeUYoxf57FZaPpILoM8ybN8z5rduYKhdGmscLlx87+g6vVUWr4+WhX3XYcac0ZkJYcUW3XKEuCOck025L2AcOgIOikVJN7mQqIBHgymu1f09s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=Z4OcyPTZ; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from localhost (83-245-197-232.elisa-laajakaista.fi [83.245.197.232])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sakkinen)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4WPGcF50VFz49Q0P;
	Wed, 17 Jul 2024 16:14:21 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1721222063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UhNWj8tbJsA/dIsV0n7TH0YDw2A+cYy/1vuKntGxdpE=;
	b=Z4OcyPTZ7t5H8qeQBOlxkGLaqCUJxVnF6pjmYPze849BB0/j1HT2hEvxc6neK64Uuc0cw9
	jXTyJg8LW+nKhxiwBXm7ylxeXcH0Na3ZxLQbvOco+7f7zlAOzgLDvcDgFlkG6D6xd5I+hN
	wRI/YQLi82TcVfIF0RrVFIisTiTNlDIYVOzYIqO1zErs9eOoIqTKA1X6kEmDSrh0ejAwJB
	oyWsMPMh0POKCQ+b7Bw1Rp6XbZD/Q8FbnrFcftEhC2XG/1GgN05BgKz/2RbveDeGHDCsil
	8URpCJOwS8PM1Biq2joq1b6hjlugC/q8jRzwVdvAdLcrP+GZC2/NgGPk2f/JRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1721222063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UhNWj8tbJsA/dIsV0n7TH0YDw2A+cYy/1vuKntGxdpE=;
	b=Cxip6k/YnP/FKV/fSiJyqOQkKAoqlFKPxZxkdT2HqrwJa4bWIXWVfvJrQZerzVAPaNVU5J
	rRychLQEXuW4/nTHJZYoGCkQoMh1JSv4byNDA7VS6AmelysY5y7rqRkzD7It2GSXNwHbwg
	SJY1EnyfFlhBiyEawkeAcm2nDRNN7zGA3GHMU8OTDK1cEqFGsRDQGypzpKWKDtx/nR3ZDf
	lWWMPGkem8ORSjDPAIFpJniGu2Yng2Wc0+UDd5FgyKKLufydyz9byD33T/1FKAkyIjIMSG
	ITtkM8VtCYWhJPafVLyA4g+JrsWRl4EnOO5erTcKMjv3nvAeiagvGkKY+fAhoA==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1721222063; a=rsa-sha256;
	cv=none;
	b=iuXoQHds7PDZ1xPeJL4JdXW6S/nboVIZwy29Tc5oAylYd2NenhPzB03lfDx4VxRyKJUNn2
	KmzAEeHUzUpgfVtCvg4yOMWdtnYf5XYAt+qx9BpHR5f4Bis7tc4BmYpkJ4ijebYuqhYlfj
	jkK22sPdFgFmWBjCI47XFkpd9syabVNS90iuyX4cEtKGbXlfEE+Dw2guMHgQ8BWvcNbb4V
	iCGSzhoucMCXG4pTgy8tocl7EWQ0Wv5svIqG4Kwu5Om52Xisx6mGYCWsNypcj7Y0TpUXph
	bh4idbsp34bemR2sjqH/CUELRaw/gG3Q2i/rgHg+IIf0r/7C2ozESixPukEkWQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=sakkinen smtp.mailfrom=jarkko.sakkinen@iki.fi
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 17 Jul 2024 16:14:21 +0300
Message-Id: <D2RUAQX7TSOM.UWLZYT2WBHI4@iki.fi>
Cc: "Peter Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>,
 "David Howells" <dhowells@redhat.com>, <keyrings@vger.kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Hao Ge"
 <gehao@kylinos.cn>
Subject: Re: [GIT PULL] TPM DEVICE DRIVER: tpmdd-next-6.11-rc1-roundtwo
From: "Jarkko Sakkinen" <jarkko.sakkinen@iki.fi>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Linus Torvalds"
 <torvalds@linux-foundation.org>
X-Mailer: aerc 0.17.0
References: <D2RU88JYHTMN.14YA4E5BCVG0L@kernel.org>
In-Reply-To: <D2RU88JYHTMN.14YA4E5BCVG0L@kernel.org>

On Wed Jul 17, 2024 at 4:11 PM EEST, Jarkko Sakkinen wrote:
> This is additional fix that supplements my earlier fixes for handling
> auth, which I unfortunately missed last time.

That said my fix did increase collateral damage, same triggering point
existed also before, but I decided to keep the fixes tag as it is as
this supplements the diff for my original diff...

BR, Jarkko

