Return-Path: <linux-integrity+bounces-3058-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D8192AFC0
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Jul 2024 08:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2838B1F22228
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Jul 2024 06:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67EA74501A;
	Tue,  9 Jul 2024 06:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="ov2rCa1w"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA7142052;
	Tue,  9 Jul 2024 06:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720505203; cv=none; b=Qkty4flDy0ERD1+le7vn8pHj+9Xehqd5nPHDOa5TGIoS7JOYF3RpH8vyDi1MQkrLOtko6VUAzLrfN1JXEWavzwVm8G5nA9vDBDnNGFh0n9qes8XxmE3DhggeiHW9byiIDM17iLkSsef2og2DThz9xSfBp68akJgtXqFiDBaSJ5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720505203; c=relaxed/simple;
	bh=AB8GU4lJy6m1ESYPkgpTF64f4Nq208/HyuonUMJToFM=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=m8CfJ9TFLHTzkx/6HVMDaCFGkEAK+SZCp/QnEjifEsANNfYi20/UMfD3LN70AeFvEbrEAGZKBkbIjr14Qu9CkuhENiWTYGyMQnzAB5Joao+/xIKGaJnUEs9mY2TzSkG8QKWVOP7nnN4K9KLX+EWielwGo3POzznOS7gOwGhX6nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=ov2rCa1w; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720505089; x=1721109889; i=markus.elfring@web.de;
	bh=vocCb0s2+QsTYPRKuzeCkB5145JJcttII2QUDPFbX2k=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ov2rCa1whGMoNF60ljpXxxNb2tEZLO50JOybCRmWoepN7R/L5eZJUCpaoSelbcUT
	 KEF0Q05v7eXFfWR16E1whVj9llB98LkgXBBFcuETAURj7LYzyC1HVFOUa9SMQOyNO
	 m9Fx8BLJkRsins6yiTMIlyfqbDHipiTRJOPrENi5k4ZjhMIm6byoecIZmBUsgPXNa
	 FW8SroTpKpEjrBS/icy+NzVLtUaZzBQiKbnY0qmE0zQEkbDGAuRFXbDGOTyrWAIpr
	 mB1idujN75Nc3BeDNqHc8xzt0Y7FBDnnMC2h17Lv1pF8mFnTiAI1KyxQbScJuDnjW
	 jbU6+TE2haihGnVTlA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MActe-1sXhof0FrM-000PbJ; Tue, 09
 Jul 2024 08:04:49 +0200
Message-ID: <fc4323b7-c7f9-47c5-a7eb-4034d2e18bcf@web.de>
Date: Tue, 9 Jul 2024 08:04:26 +0200
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Hao Ge <gehao@kylinos.cn>, linux-integrity@vger.kernel.org,
 Jarkko Sakkinen <jarkko@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 =?UTF-8?Q?Peter_H=C3=BCwe?= <peterhuewe@gmx.de>
Cc: Hao Ge <hao.ge@linux.dev>, LKML <linux-kernel@vger.kernel.org>
References: <20240709023337.102509-1-hao.ge@linux.dev>
Subject: Re: [PATCH] tpm: Move dereference after NULL check in
 tpm_buf_check_hmac_response
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240709023337.102509-1-hao.ge@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rYmMZ52qGI3wa0UJ7FqpRq1mkvewDOSlp01g4rQQbvxNCvTkeiw
 XhK26BhSOihuyvCAR5t4gjJc1HpeqjUhgHQj+J0yLpd7TLjx/Cx1TGdn5kBBWVMDGN9h2Aa
 q1wsGLdAj5eZu9LVNbIDFkgCiauwDlkYz6SeYkNwK0TYWpSjldZsfJsVdFxOOFDys7nMoN3
 YFkbfXfLwKIOgeKhtWY3Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:sPcVbkyG1cM=;PlIWtWZXFZovBqgQL5g23Z3/QlT
 DJsgzHBYGrsuel0Rwu8wgwqLK6Xz5CeXj6orRCO4w9lqrEVY2myMEi7iLHpSm6YNLsgVUY5b8
 lYBrL9xn0y8pRkOz/cIeAOfzBuS6E/NqjC2Qzn6C6ikkkdy9S0fL/hpXEXZAeLEuVrDFQO8kt
 bSgL7ubk/tg/sVX3EDf0ZlL5AXvnrPeXyVZ1apAmlNY7QPcuB2cunQ4CLdOy3FUFPLsuMX+nQ
 3ufboUv50wl/vQcgHxLNDxdySQpTaSxVcodoVatWZJkxMe920zhgwV2/MF8bFqffSfe/kBgh4
 af2MGO0YHnJFXgx+nV+eKQi6esYU4QO5gqn6qluQ4n53sWq7tAX1JJlQlp+CoHDacp2PjeUAS
 AtpZ5KbAL9MOH7p9uEmx8/KYiqBIbJg49GsUhPBdB8Ra1DHmA0RlyKN/opjBXtCoe7b2Y+Y+A
 UIaBpYXFCS2En3xKRAzcJlQZjrNEmn6aGieyJ89RLuDenLLvD3hbZkkA6lCv33vj6T3dw8lkL
 HGh7fv1gEKkyy0BylkSewGbng8weN8M7lKC00y5rZkOo22ldXWPdPNj3Sk+Qr9E2RjQlu67w5
 90jSyljgQblAny0GD5prEuNJzUfbso8QYS79VqEbAjQhF4ulUtyOVTvxq8f754Kf39c39P1BT
 KvmtUh3CQ5Sw2qrFpL51wA9LTwNEOoA4IVi0FWgWWws+DYbib1Pu0zVvFMJcFlOA78ULCAjwW
 uIcw6b1yAoxcl/GpNSqxEbLQlpzkXqcD11r4Unkt4EXmwPSsaGOoYjOOUwbhMuGSR8y3lnFGa
 NBdHnR4N3/km8GiiX7r3pqHGpUXDJ+SHWwYcWx7ZzuFeM=

> We shouldn't dereference "auth" until after we have checked that it is
> non-NULL.

How do you think about to improve such a change description with imperativ=
e wordings?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.10-rc7#n94


> Fixes: 7ca110f2679b ("tpm: Address !chip->auth in tpm_buf_append_hmac_se=
ssion*()")

1. Would the commit 1085b8276bb4239daa7008f0dcd5c973e4bd690f ("tpm:
   Add the rest of the session HMAC API") be more appropriate as a referen=
ce?

2. Would you like to add a =E2=80=9Cstable tag=E2=80=9D accordingly?
   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/process/stable-kernel-rules.rst?h=3Dv6.10-rc7#n34

3. How do you think about to append parentheses to a function name
   in the summary phrase?


Regards,
Markus

