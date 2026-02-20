Return-Path: <linux-integrity+bounces-8526-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id fdqqHBckmGkJBwMAu9opvQ
	(envelope-from <linux-integrity+bounces-8526-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Feb 2026 10:06:31 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AACB3166027
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Feb 2026 10:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15B8E3011C54
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Feb 2026 09:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92B231AAAF;
	Fri, 20 Feb 2026 09:06:26 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59B815ADB4;
	Fri, 20 Feb 2026 09:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771578386; cv=none; b=mVS/ogUkCjabcNIfPr1Evg7CqyOH0r54sV2uPWu0TBPeomtjxxlTBkRWmsM1cmBq4caJenmIv0HRpX7Fjy3fx/5EperwyRPmYeTg2oUIyj3+gVfRD2968BWBDeHOG+8LG6Vna7dp18G/oWeLWMw5rpEGvD7N70IlB+ScTrmjjoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771578386; c=relaxed/simple;
	bh=16sVxko9HV9n5CWc4iDY+WQSvl6MzmmdZ/Z1oXWYF7Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D1PRucN4REKlBeUfiOVc3ZrEgbL0qVeu5yhEY8QSwxZRbxyDKV1ePhcmmNTibPsRsGTOTur7+xir27b6eaRJqY6QPRLifqnGMC85oAnrx4NhC8NsVqQS0QixC7gzDvy/YDNEzbX3Zd2uO/WLlqSdgWWU+EJ2GAUfwGQ6mpPhgHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.235])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fHPRN3Yk5z1HC9x;
	Fri, 20 Feb 2026 17:03:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 65E134056B;
	Fri, 20 Feb 2026 17:06:16 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwBnMm3_I5hp05YlBA--.42095S2;
	Fri, 20 Feb 2026 10:06:15 +0100 (CET)
Message-ID: <c35775ef24edb89f2ec2c658c6255ac07bb708b3.camel@huaweicloud.com>
Subject: Re: [PATCH v2 v2] evm: check return values of crypto_shash functions
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Daniel Hodges <daniel@danielhodges.dev>
Cc: Daniel Hodges <git@danielhodges.dev>, zohar@linux.ibm.com, 
 roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com,
 eric.snowberg@oracle.com,  paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com,  linux-integrity@vger.kernel.org,
 linux-security-module@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Fri, 20 Feb 2026 10:06:04 +0100
In-Reply-To: <lj2loy57pavtihqeuywpc2aev7zy3k3poop346dtmelmocp75q@lbejeufrrxwr>
References: <aYNprpzxppKE0Gf2@fb.com>
	 <20260206024240.19059-1-git@danielhodges.dev>
	 <6ce273a26b396232f3ee64a980575562e766c501.camel@huaweicloud.com>
	 <cfbd9e3c63e03500279198ec7a80ba009dfccc63.camel@huaweicloud.com>
	 <lj2loy57pavtihqeuywpc2aev7zy3k3poop346dtmelmocp75q@lbejeufrrxwr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwBnMm3_I5hp05YlBA--.42095S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw1UJrWkXw1UKryxXw48Crg_yoW8Cr1DpF
	WrGayqkrWDtFyUArnxt3WrXr10yrWFkw15Xr1kGryFvasIvFn2qr4xC3W0ga4DCr15Gr1j
	vr4ftr9xuw1jyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAKBGmX0yAHWgAAsc
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-8526-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[danielhodges.dev,linux.ibm.com,huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[roberto.sassu@huaweicloud.com,linux-integrity@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.975];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huaweicloud.com:mid]
X-Rspamd-Queue-Id: AACB3166027
X-Rspamd-Action: no action

On Thu, 2026-02-19 at 10:01 -0500, Daniel Hodges wrote:
> On Thu, Feb 19, 2026 at 01:36:39PM +0100, Roberto Sassu wrote:
> > On Thu, 2026-02-19 at 10:26 +0100, Roberto Sassu wrote:
> > > On Thu, 2026-02-05 at 21:42 -0500, Daniel Hodges wrote:
> > > > The crypto_shash_update() and crypto_shash_final() functions can fa=
il
> > > > and return error codes, but their return values were not being chec=
ked
> > > > in several places in security/integrity/evm/evm_crypto.c:
> > > >=20
> > > > - hmac_add_misc() ignored returns from crypto_shash_update() and
> > > >   crypto_shash_final()
> > > > - evm_calc_hmac_or_hash() ignored returns from crypto_shash_update(=
)
> > > > - evm_init_hmac() ignored returns from crypto_shash_update()
> > > >=20
> > > > If these hash operations fail silently, the resulting HMAC could be
> > > > invalid or incomplete, which could weaken the integrity verificatio=
n
> > > > security that EVM provides.
> > > >=20
> > > > This patch converts hmac_add_misc() from void to int return type an=
d
> > > > adds proper error checking and propagation for all crypto_shash_*
> > > > function calls. All callers are updated to handle the new return va=
lues.
> > > > Additionally, error messages are logged when cryptographic operatio=
ns
> > > > fail to provide visibility into the failure rather than silently
> > > > returning error codes.
> > > >=20
> > > > Fixes: 66dbc325afce ("evm: re-release")
> > > > Signed-off-by: Daniel Hodges <git@danielhodges.dev>
> > >=20
> > > After fixing the minor issue below:
> >=20
> > Already did it. The patch is here (after fixing a conflict with
> > 0496fc9cdc38 "evm: Use ordered xattrs list to calculate HMAC in
> > evm_init_hmac()"):
> >=20
> > https://github.com/robertosassu/linux/commit/d5aba42198b602c6de002ef02a=
4e6cc1d75652d7
> >=20
> > Roberto
>=20
> Nice, thanks for handling that!

Welcome!

Roberto


