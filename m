Return-Path: <linux-integrity+bounces-4195-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5D09D8AD4
	for <lists+linux-integrity@lfdr.de>; Mon, 25 Nov 2024 17:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DE3BB28197
	for <lists+linux-integrity@lfdr.de>; Mon, 25 Nov 2024 16:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3081AAE0B;
	Mon, 25 Nov 2024 16:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Z+NpnZHl"
X-Original-To: linux-integrity@vger.kernel.org
Received: from sonic314-26.consmr.mail.ne1.yahoo.com (sonic314-26.consmr.mail.ne1.yahoo.com [66.163.189.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865A42AD25
	for <linux-integrity@vger.kernel.org>; Mon, 25 Nov 2024 16:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732552050; cv=none; b=VCLWanekH5uafOQb+tqGtXezzcjxzZVP6yVxCiPb79GgCwoi3e8CQuW6KtrYeLOs6Ac3q+O+ylXSzW54B0VP0p9wVgUyio5omatN6nFofdHIHgjtT4VAw4qlRo9HZ4bqMYcZVSW6ndq95WrdQFeyciZouZAraAOvfYySMQEYi1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732552050; c=relaxed/simple;
	bh=whGppg4N8FjRmslnuHtBglVsSC2aa5K+2Ql0N8U0pn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BRsZGEESbF63abd0/p2GRaw5Uu2jqulrku4CdyRawVWmjm6mgI83eiXlD3SMX0iIhDLLExKyA/Jd2/a0h701yvxmx9dSWaVI6Mbej9Sq2p9uz6+J+RSwiyCJiHQJYfDpvni+QLLgf7vnqbvtFEh7dy6VNnNeS3fHieWE7XXOkFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Z+NpnZHl; arc=none smtp.client-ip=66.163.189.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1732552046; bh=whGppg4N8FjRmslnuHtBglVsSC2aa5K+2Ql0N8U0pn8=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=Z+NpnZHlb3aRGKTH2D3BdujAeDj/P81a1y/rIyEdqok2cOFdkFg5EQZ2sTNu7z9Fh6CkxRcm9kzdV9DxWVIVdec+i1oMSep0rvJbPbTfIUvw8uFE5xKHQMqqJ3AjFzyia23MCtSCe1OMi3kZje0loYc7H8uPC3/dcKQ5cUZYPTqvnYtBsCa1/1C6zUwkNQfFIDbM18naKAOSXh7JgWJljrzurOA2NuD7quQ9UL35Cha6yvTuIuLevMXGbRY+ON2ECzS7H+0moR5lBp+mOEf3XbtHtLA2rrZtr9Pf6zSNAsLH6BavPnkYucElh1JwtamJ/6IHeQna//s4qFjHJyadOg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1732552046; bh=RgGpvxf4q1+falM26WQn1sCmPwYOneZqQ60KkSpuPRq=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=GaXWYmd7m1NIT9HCSqWTIoa7Djff4lvozhWOEmrylK7TKywPX5QsGcJp62eLWHLHDcY5Ch/RXoif4tW/K85AC/EB8mY/ntyuzQvIV828Ida2a9CEfodFEPpl0duqFvRs9faVpdhPy0r835Jz9nr+oJf9XLZK9j+mK6ovGZCYIwo0HDxI8+uRkBtWjw7cKnQWl6rJs629gHe2g0DMrAsYs8f/Sj3fuHcpoOB9QZ48CtQH9jAj20YajhSyUw+Kc3YAmvtiaravzGguA4e2tXSBojd8PpUs4dt+t4QH5t/FBnoiezfSspXfqG3nJZKxyk6CnU2cZjeO4KWwgoPakrSGJw==
X-YMail-OSG: 1cLb0E4VM1nFG9wl4RMQuOD4adgmyvg4gyphdd2istLZsWFwDbnKrExOirlK6Io
 .r3EMMciinjDcJHAo2FoAmV1PQ8du1esbYKCBqhnfKE7w94CkAUZhb33fDJQy8jnSSg674GpNQFD
 Gxr17Js5QV0V1nF.0ex5Yb.So9vFhEhLx6XTvj2NKdRJGNucOMQO1DAlo.I9yW7W3bcemXAUsEVI
 .ib_da3MCnVrENuiyttct2pREMOHWzLxFi3urXEL5biqURhf8h9XmpgrnWbJipXCa0qQKuyNTF3S
 TOMPMdnyRnsdH7Y4ddmrx7J4tkowOAwcoCd_l4GhHnwWF75l4n6dEN3z.gvSlFMK7u5_4bWsmp7d
 7STqOe.yha3EYVXimj4L.WCDtpowBkzx3RIYz6QfSNnvex.u16sck4A_fixAG3qCL3HdugAoLSLc
 ruoN742G0PBDKV9xv14N0vzn0gWtnJCXSk.gl9ePJlt88iHsEXmChZt0BAo1.hggyXYoXTrXJNIt
 xeUDLr0ORG7yFV_KGS6ljYiiW2Teg.k32QeAk_1EF0v_qCSDdbsVE5j5GabCCh1O8JXUHyXVDRmh
 6Xx29hVvRXVWvRPc.lgJTKde5GjSZjVQ_BqyoyyKoth1nSZe9ofb.MVpRXvvWwENYS2Y6IZ8L3aj
 AlWYXSg9c1qlTUivEYATSS8UY1deor_3aGC_HDAYplPsSC4Sgz8boYAdGB0ValcjlKcHdxnNl0KD
 UHT9yrNSW14uQ5TzQYrU5v1TmvCxxfoWzULO5Vn9Qj7sqmg_C6odH4wG1K56moHu47uxjvvx41dn
 R.Zo4.ZK.e0zKXRlHab9xBsovGFAtfwUNzA0zIpRPGpGMiESyQeIWWC6_peYcH07wSW18M6jRINR
 o2Mok6uBSjlsc.KtWXg_tL34FNhWlSFnGvj3yY22ZoMqi11TZmrrwqRA.NUf.xYXAr_kABslcMaK
 uvLkWTNQXQfN7alRxjGiwiRr.lONZB4gG0EIcXD2aF1HslQB50j2NmjoSIdPnCaPj0VLw1uxPU8w
 fk_hTRnPGSmNpVYAw0dRPua7_d2ezfooc74avVBXMXzTQq8LVzQNT4jSEVhVfFVyo_ajqmn4h3x3
 J_3vX.VUfKS.j.FW1SZm08ya_wtDEBQHWOWAJQzQZOxGo1P5wLe5CzRt4QbjpnXec3xtRs8q8CIk
 P3B81N3dAi.IEVde05nKSSjKE2ng4Nu8FkSyd4h7oNlqOj4fNKpr3qlMn7z7igu8Dp9AB_jF.TzU
 ErdL3bN19apFoqeiwPRXb8lOsWkapEh3uUW9GujyxftJqDKU0sGHYSU642K7Tmzgpn69mzBg5Flp
 MZbTD6KN9VKTNJp.CJaB_vWjRGmGPsZ7oZQDuXLH.RhPUbcC0Ecm6OYqlQSj0UI4.CATl37vGP.2
 UYE2pY7P6KOClrBF6q9BS4xPKbJGf.PJyuh20mKnOAhUavfjWikH1i6LOeInbWQUfdQnH.rULBEy
 CFkl1p6MePy1xIubt8oA8Rnn6zrGjX2q7e4jrJmXNOvk.NHrud09t3iYb9zNRpY7b7kRICr16yU7
 QZ9av3.ouoJkZK4W_CLnVPzp5yLI_QpQZH6d_9pB2WML7jkyllRWyDFYWldsU5bo4KpfCeZMTAWN
 BTVDectV87OqGZSniK0KgfD0Vndv14w3eQK81Mc.n.mcZawuKMeWcpXJhJ0FYBLbkIeIoFBXQM1S
 wOWXIQ7zes_1mmPIQBKB.rg59nmULhwM4UlBkr6zoBF4VpWAsfBmNbFniGuZgbQuItrO5O2G4cJD
 mCWvMgm1VFtjg4B5CyDy0GdFiWItqBfb047dXwcSO_NYQeDRxXf50ll_28hf3j1J6OlV_4P0dm1z
 vxlGguBqhZVEUY8nWCgBxYPtUT00MTyEBBxjFRfnCTxqxrjVA8zzL4OX2EXDo.L2c3s7Qq3FObUo
 CCRJqJQGOn_MKsfkIECvUwjWgTI9nscxUIh3DV8n6iXiE0if6ngJ7hTSwWyRrbFph9a0NES_hUu5
 x2Bzal4Ds83qHfg4vSE2vJ3KVESMD4tTmBscTxQNJSJVoNN6z9k5JE2wJ6SBKS7TLY9jqJnzTsa0
 sDOhf3Ub6_o4r3SWm0vpGNESqL9qT5TbAacqmVL.n9V5UyLU16INblxM.44mZZ1OxnqC4tEU_4n8
 _iN09rT8lkbSgmJfc.SveThXvJXqe3bs3TavrhtkdPFwKTKyjoWpjJILh5FuBQqnKDkDtF0dWInD
 p9P6ZJ8srjuQNfzx7fgfntG6kTQ5ln8EsYmtVuCyC70fjCzH34zFvteux5BxYo5QPM83IRW_fFCD
 FjoPhLzUllrTZ_soQnw--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 5ed018ed-2811-430d-8746-ad03e4cd5110
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Mon, 25 Nov 2024 16:27:26 +0000
Received: by hermes--production-gq1-5dd4b47f46-bxhh2 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID d8ff943e1954f7f718628fcab0543a7b;
          Mon, 25 Nov 2024 16:17:14 +0000 (UTC)
Message-ID: <85139843-047b-44be-a1c1-4b0110206cf5@schaufler-ca.com>
Date: Mon, 25 Nov 2024 08:17:12 -0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ima: property parameter unused in ima_match_rules()
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
 linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>,
 "M: Roberto Sassu" <roberto.sassu@huawei.com>,
 "M: Dmitry Kasatkin" <dmitry.kasatkin@gmail.com>,
 "R: Eric Snowberg" <eric.snowberg@oracle.com>,
 Paul Moore <paul@paul-moore.com>, Casey Schaufler <casey@schaufler-ca.com>
References: <CAJ2a_DeUX9UdAYOo9OwG-yXSH1etKQZortPcyxfzG70K3N+g7g@mail.gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAJ2a_DeUX9UdAYOo9OwG-yXSH1etKQZortPcyxfzG70K3N+g7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.22941 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 11/25/2024 3:38 AM, Christian Göttsche wrote:
> Hi,
>
> I noticed that the `prop` parameter of `ima_match_rules()` is
> currently unused (due to shadowing).
> Is that by design or a mishap of the recent rework?

Which tree are you looking at?

>
> Related commits:
>
> 37f670a ("lsm: use lsm_prop in security_current_getsecid")
> 870b7fd ("lsm: use lsm_prop in security_audit_rule_match")
> 07f9d2c ("lsm: use lsm_prop in security_inode_getsecid")

