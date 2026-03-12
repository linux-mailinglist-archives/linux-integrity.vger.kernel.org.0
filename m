Return-Path: <linux-integrity+bounces-8983-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNkXLkDWsmlDQAAAu9opvQ
	(envelope-from <linux-integrity+bounces-8983-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Mar 2026 16:05:36 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C186B273E63
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Mar 2026 16:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3FBDE3040314
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Mar 2026 15:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF1F3BED22;
	Thu, 12 Mar 2026 15:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="bGvJqXL+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o81mzw52"
X-Original-To: linux-integrity@vger.kernel.org
Received: from flow-b4-smtp.messagingengine.com (flow-b4-smtp.messagingengine.com [202.12.124.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D614399347;
	Thu, 12 Mar 2026 15:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773327818; cv=none; b=XphaSVm7qbmui3T9omzQV3SoXjeq4egn8IkRIFs1Nt09eATur+S2xgC3yHD11v6TpL/DE5Ci2YLC9pEh/QkV28cxJZyHf7VYQLxWW9DjgfXWM//FAk+jTZkFCivxzQaa0JvOu9hg4dqF/XyA5W3+z4GrRhzMubnktNf9uDmfsrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773327818; c=relaxed/simple;
	bh=4HvxgeI3PO4yA0pphzfGBVWxJBn7uDgm1lDw/UyhGFI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=GJbbSa/7B9yvVg+xZVpYlPou2OJpwdhWbfU1vq/gToRcqQyQPTrb0knvRAnEKZ9H4Dx8/5l2F9z0u50nJ1Zbh8T/PWIte5r4KevFzhqSmX8uUN+qFKOyWU7LfQE1gzYsBe9ijyAAqaA7BFfsUIm+wsy8jY3uuIP0H5Hbx+wtBBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=bGvJqXL+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o81mzw52; arc=none smtp.client-ip=202.12.124.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id 989381301A09;
	Thu, 12 Mar 2026 11:03:34 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Thu, 12 Mar 2026 11:03:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773327814;
	 x=1773335014; bh=SaJoBOWdSuPgCxv7hYpeAKeVFQyklTNNXObk3qvPfvI=; b=
	bGvJqXL+CssgN9qcX6cryh57mVbGY/RIgqlwo0DFIBN1SUBMT453trmu9eYBrm37
	hVMySZEnXc1sCYAT9luPhCcccEYQp/GcoeeL5U11WztDI9Kos7lHLrpQ7DSbCIFb
	VLAX1fDkP4Nbox42DREjtOpPaVpQ2CaKlMC0wEOW6Ixb98oVCagr9dRR/BRbIaPl
	K/lb1IRzMjRLEPNHLPQSjcHtJQ1m20e4/ueYZYoaNXNdTsNxeu1Gejx5wqTYw3/Q
	RpyIxEQzLw3Ffvb7AgeIffzCQVwtg6Ehi2jf9DErhilCuB9EAgUUQolo0Ybod/MK
	AAKTvyOsypVX9Hsl7BV73A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773327814; x=
	1773335014; bh=SaJoBOWdSuPgCxv7hYpeAKeVFQyklTNNXObk3qvPfvI=; b=o
	81mzw52m7Y8g0esA44ovBldf2w1mCxrd2Nk9Hq8Q6NGnMoMh5sV1H75k6hYOWrkn
	/IqenwKMsv4+S+qDpNTCEa08jDAdQW4w94TEalRfExX+/5d9PfHjY+TEoW+X2+FE
	nFWMlydaHFMouUdZ/ynE6XSlGki1Iwh7MbfViMcd7rfUxiDrbaymgAmqcCF2/f1F
	cAQXtApjwSKqnLbWj14/DUBi6KTSwyGikFO7OdhTu2t8k4XPTUo85uY97bxS6W+o
	Sai+Jorj6mgUE1c18wQdKIG3yLYOGQ4rF1wH3nc5mWaOz/5kRWpuG+ckYl2Q0kTR
	2GoP9XsLVT3rcDlxDQxYw==
X-ME-Sender: <xms:xdWyaZDkEMiQgozqvnBiLyFjtP28g1ahKIBoyZrE_DaQA6uTpqgKTA>
    <xme:xdWyaSWF2czmKEqMg2Cvo9TuyFgPMGQGQ8na5IFTOatpC2gB6mVkngxTfEJgl3h66
    xHSsQTi-DP2fTzR5tNK-koMttWfQPwS9rU9OAGV2evxTVEPYx7rE-NE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeejtdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepfeeuudfgtdfhfeejjeetfeeutddufffgheejjeekudelkeekvddvvefftdejjefg
    necuffhomhgrihhnpehtvgigthdrshgvtghurhhithihnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgs
    pghrtghpthhtohepvdegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmphgvse
    gvlhhlvghrmhgrnhdrihgurdgruhdprhgtphhtthhopegumhhithhrhidrkhgrshgrthhk
    ihhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhhpihhgghhinhesghhmrghilhdrtg
    homhdprhgtphhtthhopehsvghrghgvsehhrghllhihnhdrtghomhdprhgtphhtthhopehr
    ohgsvghrthhordhsrghsshhusehhuhgrfigvihdrtghomhdprhgtphhtthhopegthhhlvg
    hrohihsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnrghthhgrnheskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheprghgohhruggvvghvsehlihhnuhigrdhisghmrdgtohhmpd
    hrtghpthhtohepsghorhhnthhrrggvghgvrheslhhinhhugidrihgsmhdrtghomh
X-ME-Proxy: <xmx:xdWyaRetzDGkS5SKI9bnsPzbkpuMdRANOtnlcfTJPNlcWisTF1b1rQ>
    <xmx:xdWyadUGzj6XKM0U8A8TXpxoxcXoRD1syeMM2bNSJaTyZXuR_9okgQ>
    <xmx:xdWyaVGeL5I89cDQK5OzddGLqJwI522nV9L0TkeDyZinXQQiEKbXQw>
    <xmx:xdWyafdE08ACWNnAG8Xfy_DAQnVumhTLT3b6G07k1mGbHRJic4s2OQ>
    <xmx:xtWyaSNd2Rb7zlX_iGsR_SmDs79ks89ndHprjg7QyEwUf6Qyb8gfZZoH>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A99AC700065; Thu, 12 Mar 2026 11:03:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AHq5N6LSCfHR
Date: Thu, 12 Mar 2026 16:03:12 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Nathan Chancellor" <nathan@kernel.org>,
 "Mimi Zohar" <zohar@linux.ibm.com>,
 "Roberto Sassu" <roberto.sassu@huawei.com>,
 "Dmitry Kasatkin" <dmitry.kasatkin@gmail.com>,
 "Eric Snowberg" <eric.snowberg@oracle.com>
Cc: "Madhavan Srinivasan" <maddy@linux.ibm.com>,
 "Michael Ellerman" <mpe@ellerman.id.au>,
 "Nicholas Piggin" <npiggin@gmail.com>,
 "Christophe Leroy" <chleroy@kernel.org>,
 "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>,
 "Alexander Gordeev" <agordeev@linux.ibm.com>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 "Sven Schnelle" <svens@linux.ibm.com>, "Paul Moore" <paul@paul-moore.com>,
 "James Morris" <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 "Coiby Xu" <coxu@redhat.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
 llvm@lists.linux.dev
Message-Id: <d2089740-16d8-4ca4-a61c-8c381f8e30a0@app.fastmail.com>
In-Reply-To: 
 <20260309-integrity-drop-weak-arch-get-secureboot-v1-1-6460d5c4bb89@kernel.org>
References: 
 <20260309-integrity-drop-weak-arch-get-secureboot-v1-1-6460d5c4bb89@kernel.org>
Subject: Re: [PATCH] integrity: Eliminate weak definition of arch_get_secureboot()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arndb.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[arndb.de:s=fm3,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-8983-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,linux.ibm.com,huawei.com,gmail.com,oracle.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[arndb.de:+,messagingengine.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@arndb.de,linux-integrity@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux.ibm.com,ellerman.id.au,gmail.com,kernel.org,paul-moore.com,namei.org,hallyn.com,redhat.com,vger.kernel.org,lists.ozlabs.org,lists.linux.dev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,arndb.de:dkim,arndb.de:email,messagingengine.com:dkim,app.fastmail.com:mid]
X-Rspamd-Queue-Id: C186B273E63
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 9, 2026, at 21:37, Nathan Chancellor wrote:
> security/integrity/secure_boot.c contains a single __weak function,
> which breaks recordmcount when building with clang:
>
>   $ make -skj"$(nproc)" ARCH=powerpc LLVM=1 ppc64_defconfig 
> security/integrity/secure_boot.o
>   Cannot find symbol for section 2: .text.
>   security/integrity/secure_boot.o: failed
>
> Introduce a Kconfig symbol, CONFIG_HAVE_ARCH_GET_SECUREBOOT, to indicate
> that an architecture provides a definition of arch_get_secureboot().
> Provide a static inline stub when this symbol is not defined to achieve
> the same effect as the __weak function, allowing secure_boot.c to be
> removed altogether. Move the s390 definition of arch_get_secureboot()
> out of the CONFIG_KEXEC_FILE block to ensure it is always available, as
> it does not actually depend on KEXEC_FILE.
>
> Fixes: 31a6a07eefeb ("integrity: Make arch_ima_get_secureboot integrity-wide")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>

