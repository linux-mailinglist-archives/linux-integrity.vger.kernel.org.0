Return-Path: <linux-integrity+bounces-4196-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 172E49D8B4E
	for <lists+linux-integrity@lfdr.de>; Mon, 25 Nov 2024 18:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D832B29E9F
	for <lists+linux-integrity@lfdr.de>; Mon, 25 Nov 2024 17:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7CA1B392F;
	Mon, 25 Nov 2024 17:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="iVI7SupE"
X-Original-To: linux-integrity@vger.kernel.org
Received: from sonic307-15.consmr.mail.ne1.yahoo.com (sonic307-15.consmr.mail.ne1.yahoo.com [66.163.190.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B16191F91
	for <linux-integrity@vger.kernel.org>; Mon, 25 Nov 2024 17:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.190.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732555190; cv=none; b=u0ThLg0wUJt+dh/y+YkqRKzvbGyVxUg+aEV7nNY7+pLgU0l1vYA05dOOBHeuj1aUwLzaOddBV+f0enbo/rOnvdL0QDqwCeE54wWDEqsgYFUMd/d9wreanJOK2sk3kyOttqu+dl3/4c4oL/p/FkuEdJxX6ji2G6d19IYX2f6EhgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732555190; c=relaxed/simple;
	bh=lJRvvnydgZ7e+CPGeX56leVCzDBUCU9xTa0lziZP0Ck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c79LQ5pIjPHzmfo/yij/cP/ATzgHPscfj6W/bWSbn0vnj7wlVZtuVDRwXFx91XTTv7nezDXkjOS/gT4ezZ6QnavcNW2tsWk+pfSoS1sEj4JiSsyfVhloC+9VfmDsQeQOJk9lErFNOAnh6IuSqLRmo6UP32OjSrKaSIyw1KHXOio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=iVI7SupE; arc=none smtp.client-ip=66.163.190.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1732555187; bh=lJRvvnydgZ7e+CPGeX56leVCzDBUCU9xTa0lziZP0Ck=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=iVI7SupEXArNWZ/NHJf/xvf89o6N8WPsEZ2cnIz98Wrk06ca+P4vK+1b5GUV0DpG+GYfl0lDharEXvPfkgdkTZvFIm8Bltmgsy91UpzS+bUsFXVoUW4+aJFjgjZeaRFGz/ibZjwmMAMHq5f8O2TVcJlzdUNc/YcEMx9KrBpPQpRwC9wj8Hg4h1x4sIHibAzYSh+aBBh/IWrPKOmLW0JmP+/w53VbJ0QeX3INq8+CDL4IqLZCRfLEGx8+CyRxgX+zuk8fo9yNMJpekuMTj7I0veGRMjnlSJERL45xmpelszzsbcfRqictktKTYkf8uPIG1mX2rzkJvi2YeUWNVLfJng==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1732555187; bh=2cibPiKwl0mV5zpfFI9cIhoYQ6BN5VFFUTo3Pvycmf1=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=qXh4Ya1dCB68YjjiqhXoDSAY/dHfHlLFO8PAwi+aWyIH48wv1hKN76Et52kCWkyw8m9kaQ8nzMBXtsFD7bp/I8kZxSLs/GvtfyVzM0yCh9Bp5csGfy6lCWwkypgIf26uQUEhD/C0UgxSWP5Kh03Igu5qtj0WoFwTuRRooydSmp4jZSZewyFnKrAbHsZWkoX/Nr/NeGR1psmTlzw8n13rs0fQ2Q6k2lVc+wdgtI8az9T+V8LEbNLpOmuN/u+57MkeeP7Nj791d4iKNygthwwtvykItKvaXbS1YqWcIQFXXbHPdFvieeCHbsj3B56EioNua0NhKmsF9EmDgv4ulIEs4w==
X-YMail-OSG: OEK8lAcVM1knKENcJRt4U2hbBXlkPj6Oe1m6Op6W7MM5dTmosSFMbPp8_hjMQmQ
 PUQFgTux970vq74.i3viDDYvx8GjjOKb6j3RA9B09acl7QT1TJeT0_jXYtxLijITzgSwqFR1NXaP
 1HmYT7SX.cNdm73iciHQW1iUKS8hlKspx1Ej5Y6phDlOKE8xOGd.dKfLpvX7hbuXwONos4naTkeX
 knn8Djrk7hL_a1Icd7OhmVlbt2n.jcc8fsabrTpRVfsy5SROei.MtKioclG3aYtBtvQ5z95yfl98
 oOeD_k7DM6ztrpRKKd_1XppmzRDG4JNFPOTQ8Th39ZTbtlwIjstrCJu_UDQqkQnRQcPQXBfwfaDM
 Nagoo2dHCeSfS6AXXBI6SU_n_hjFhu2zcdgazvjYSHjLwj3LLTTQIu0VfN0Ac4kcUAw1xmloaBCt
 C7RJG_Bq3k1lobjJOANKJfzzsiv_YZeYUxk7DdNS4fEO5HnPXDJWRRb5liA96AGBDIcbsjX9_iCK
 FBLdUM3nA0H_uItngM5Qg45rJUYR8NbTPg3mY76QWngjaXrCEsgs86felLg934faXjuA4I677Eww
 tFd1YevTrj6s5gkkPmWUidbo_EKM236WVHPF1zPiuU4xSzZ3jxtg0njZTLBXkhPFpSI6cWMSRr.I
 8bQ6qCjw0V6GT5Hwx2z7s5blimwyI375PblECN0UhU5yBpCvzuuKlYqU1MznDRCvLSkkJKqAkpfe
 GLVm_1m2fSbPict..1aKOPEnPNuFbp3QDQ5K3Fs3A1INYr2CL8sGOKkVDSXDPO5exqYjBWwmfKW2
 D5_sb22DTKW8.yrT7YYufP_V8P5zjXmEM6lqyggEhD3JBsglVIpaks9tPpJC4_ZMv2k33TyZRS81
 T0rNkqaAVtRVHfae3aw2wmeYaJqJCeqBj_WjF5pg3VqC1r9MEMFzQpj1GLItPA5wp.J8HkKUSNKh
 F8zzloD1FyJK4Ob3uljuYbHw4Btry8tcwBDnhITUaFMmYUGCFEiqSgEQBlaS4Jfd8.aO7Z4NxdBw
 ju5Z_kS8iPki3MMCbO080x9f.9uokOGaaGTjQj0qdneptHu04bL27JYsrGG6VrJOfTg3lTsAuHJn
 zf8OpsBtU4Ao4RZ5YLbft.92wRdblg2gHkvIeJxnpunqRq18hUk2ugzm9GDO9i7sPZjFvsrMZ7yo
 1Oce8985N_0LqD_3oFKQnlp0wT8p2G9JBGUgftEJ6Tgi625hlawS4rb1R_x0.cLvTy7Wg_VnnGXQ
 GnUzvRs3wmjnZ.mifQPyhd.3sj4hzH3A4v.R5bbdE7Z6Rxvy15rQe7bfPIB7tgcwV1JzCOlA6hyb
 MOETS5sGUBS5jDRX0YaCIAKuxjwVIOMdtKxQpZzKLy5OeZLm4iiaOaYxy534Bk7RwU9EGoL_3W1G
 HwAQZ_IIAbz5.IK1CVQ6K1sgMNGJbMb0v.0Uex7YQeY2alcf.H4nxyMotHmj9Gc8WoBKOgoiLNeO
 YvFnRWErWHWOm5Pma_XYDsbVySjTtDyXDgSjAHfNRgKspvRw84NL.BBu1sDVqDtSIRok3OKeuF9X
 IwMKD34oF2WC9nH0vpcKtBKdSgxFtozHdZ4ZaCuxkF0w8Qw2unl91G17fjJdtjDeFQSpmax08VYX
 VXWviEsWkHnpxZSDrZLAD5r3wej7i3tVO64UM9ys4tNsWKxaRVXvh3lWDfznQaOQU8MCon8dJxjY
 AjAXqLDPY17tz3UdGeOptT7opde.jbImNUvFvubJzXWTE3oXIboGjZf_.uNzb6yrREH56Iyh0.LI
 VOh.Y9EnBL1Dk4Ih_ZpRLZWaYA6eKh2iC.GIFazTB8Uu77D1i5DFhN_VNG2tvsUoNS8bvzd3DdYe
 iz2EXtoZftQvTX7id0KQql6SwJbbwVoWcrfdNIuh6CtwuLz_tT.FZZJ7WtfTQ_bXfSZbCrMNfP89
 _oLbSe0TS9Ex0KIIyRbwMvtU518avFPo29hQokk4CwTILKxkDDQgdP2YtboLDt03HvUEcZoMaiWG
 3.vLyHCApgvRkcCRrA2GSJg4zHzy5UdPNbz1_qUjFEJmSy8TJueuShIff9pzx0druocz.SkdoWXr
 zjt8ZYpOI2it.KvxkYyVW6ORThqT.lA2CeUI4lC5eNh.UvwbCRAKEEk8Va7ILKGkFhIp5xBsnQrt
 AANCrcs..6PxMUjQLFpFuQhlYdGrRfhOhxQtGE4xG8myA.X9VB_3yZ8J8mqzepsvAWn7jwavQykZ
 zILOVo87Nwayjlh4V9A7W2MbROvj.OH_CVMUV.HCpO.skAAABFDEU9VMGHGJ1z3esDmaCOnMSkFG
 JXAzQACW6AU_d
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 8586146a-a704-49bc-a6f2-7bcbb063a501
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Mon, 25 Nov 2024 17:19:47 +0000
Received: by hermes--production-gq1-5dd4b47f46-dvwsq (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8ee06340acfb4fb145d0face8c61f4a9;
          Mon, 25 Nov 2024 16:59:31 +0000 (UTC)
Message-ID: <3d718fa2-b043-4a75-a3f5-3b9dcf739b32@schaufler-ca.com>
Date: Mon, 25 Nov 2024 08:59:29 -0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ima: property parameter unused in ima_match_rules()
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
 "M: Roberto Sassu" <roberto.sassu@huawei.com>,
 "M: Dmitry Kasatkin" <dmitry.kasatkin@gmail.com>,
 "R: Eric Snowberg" <eric.snowberg@oracle.com>,
 Paul Moore <paul@paul-moore.com>, Casey Schaufler <casey@schaufler-ca.com>
References: <CAJ2a_DeUX9UdAYOo9OwG-yXSH1etKQZortPcyxfzG70K3N+g7g@mail.gmail.com>
 <85139843-047b-44be-a1c1-4b0110206cf5@schaufler-ca.com>
 <3a3a1a22-636a-4ac5-ba12-4c59eabad664@googlemail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <3a3a1a22-636a-4ac5-ba12-4c59eabad664@googlemail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.22941 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 11/25/2024 8:22 AM, Christian Göttsche wrote:
> Nov 25, 2024 17:17:19 Casey Schaufler <casey@schaufler-ca.com>:
>
>> On 11/25/2024 3:38 AM, Christian Göttsche wrote:
>>> Hi,
>>>
>>> I noticed that the `prop` parameter of `ima_match_rules()` is
>>> currently unused (due to shadowing).
>>> Is that by design or a mishap of the recent rework?

It's a mishap. A patch to correct the flaw is under test.
Thank you.

>> Which tree are you looking at?
> torvalds/linux:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
>
>
>>> Related commits:
>>>
>>> 37f670a ("lsm: use lsm_prop in security_current_getsecid")
>>> 870b7fd ("lsm: use lsm_prop in security_audit_rule_match")
>>> 07f9d2c ("lsm: use lsm_prop in security_inode_getsecid")

