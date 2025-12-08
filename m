Return-Path: <linux-integrity+bounces-7852-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E93DCACD2A
	for <lists+linux-integrity@lfdr.de>; Mon, 08 Dec 2025 11:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 362D0301EFF1
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Dec 2025 10:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C07430F92C;
	Mon,  8 Dec 2025 09:40:39 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FFF30FC08;
	Mon,  8 Dec 2025 09:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765186839; cv=none; b=CmveGpT2+Wh6vS8vFZ9EjnSEHmK061W9GANaAcofNOFWBGBhwEtnjyDYX+DZx4vAg2vRIA8uTYET9NIIcM1eiCI50DrnccvtHe0aWmCjDKsfpFCjoG8vQEvEhK/byXF7I5xAr9c+PJEPoTjE6p+AQ0cew+zOqY9HXrvVqD9FiJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765186839; c=relaxed/simple;
	bh=ApVCzoHrO3LiSX/h6tTiYJ58UfrJTZDWxlIPqu3K7ek=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OLMlJiJvEgdkSaZE1/oKGmY9ri8qptGTpCqWkYAzzDFzohFLib8I1IzXA3HTdUDVpo+9xWhuFf9urDT4hFDfXP2pFrLdyNYgOTYi2XhfgHpvnn6F/LZgtKtNiyVQzPP+iJYBRa51fPaVuna32tavDDP/7OyaWSAR2jLZtnrwuWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.196])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dPxkg3ng1z1HBL3;
	Mon,  8 Dec 2025 17:38:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id BA48940567;
	Mon,  8 Dec 2025 17:40:24 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwDH2Qr+nDZpc+CLAA--.4528S2;
	Mon, 08 Dec 2025 10:40:24 +0100 (CET)
Message-ID: <1ca00e3238e804db9280abf8655364c2662754ca.camel@huaweicloud.com>
Subject: Re: [PATCH 1/1] IMA event log trimming
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>, steven chen
	 <chenste@linux.microsoft.com>, linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, roberto.sassu@huawei.com,
 dmitry.kasatkin@gmail.com,  eric.snowberg@oracle.com, paul@paul-moore.com,
 jmorris@namei.org, serge@hallyn.com, 
 linux-security-module@vger.kernel.org, anirudhve@linux.microsoft.com, 
 gregorylumen@linux.microsoft.com, nramas@linux.microsoft.com, 
 sushring@linux.microsoft.com
Date: Mon, 08 Dec 2025 10:40:10 +0100
In-Reply-To: <34d739c2cf15baf78dff5acb7ae3ddd7ad47f219.camel@HansenPartnership.com>
References: <20251202232857.8211-1-chenste@linux.microsoft.com>
	 <20251202232857.8211-2-chenste@linux.microsoft.com>
	 <099492ee58996b6f18d73232677757ecadb14cb7.camel@huaweicloud.com>
	 <34d739c2cf15baf78dff5acb7ae3ddd7ad47f219.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwDH2Qr+nDZpc+CLAA--.4528S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXF1DtFyUKr1kCry3Gw1fCrg_yoWrAr15pF
	WSgay0kF1DJ3WFkr1v9w48Jr1rA3yfXr15Cr10kr95Aas8WFyI9F4Yk3yYvFykXrs2qr1Y
	vF42qr98Aan8AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAQBGk1bGtFngAAsW

On Fri, 2025-12-05 at 13:30 -0500, James Bottomley wrote:
> On Fri, 2025-12-05 at 10:30 +0100, Roberto Sassu wrote:
> > On Tue, 2025-12-02 at 15:28 -0800, steven chen wrote:
> > > This patch is for trimming N entries of the IMA event logs as well
> > > as cleaning the hash table.
> > >=20
> > > It provides a userspace interface ima_trim_log that can be used to
> > > input number N to let kernel to trim N entries of IMA event logs.
> > > When read this interface, it returns number of entries trimmed last
> > > tim.
> >=20
> > High-level comments:
> > - It does not offer the possibility to keep the hash table
> > - There is no coordination between taking a snapshot and the readers
> > of
> > =C2=A0 the measurements list (I think it is necessary, since reading is
> > =C2=A0 based on *pos, which contains the entries read until a given poi=
nt;
> > =C2=A0 if there is a truncate in the middle of the read, *pos would sti=
ll
> > =C2=A0 refer=C2=A0to the non-truncated list and the next read will skip=
 some
> > =C2=A0 measurement entries)
>=20
> Rather than designing the interface absent use cases, could we give use
> cases first so we know it fits?  I really only have one: the keylime
> agent, but I believe it's pattern, which would be get TPM quote of
> logging PCRs, certify quote and then trim the log up to the point the
> quote was obtained will be a common pattern (at least I don't think
> anyone would trim the log without quoting it).  If you're trimming
> based on a quote, you know the end hash of all the PCRs and you want to
> trim up to that.  Since the log is fixed, you can work out what the
> index offset is, but it does seem a bit suboptimal to have to compute
> that, which is why I think trimming by end PCR hash is useful.  The
> main point in all of this is, I think, that you don't really get to
> decide which point in the log the TPM will quote: it always quotes it's
> current PCR values, so no-one who cares about log quotes can select the
> number of entries first, they all have to see what PCR values the quote
> returns.
>=20
> > - While trimming per se is ok, I like more the idea of staging
> > changes and letting the user delete the staged measurements list
> > later
>=20
> I'm not averse to this, but keylime won't care ... it gets the quote
> and the log and it will verify the log before it will get the agent to
> issue a trim.  Is there a use case that would actually need this
> behaviour?
>=20
> I also think having the base PCRs stored in the kernel after the trim
> (in a way that's easily consumed, like a non measured log entry), thus
> allowing verification from the log up to any current quote is useful.=20
> The reason I think it's useful is the attestation token one: I can see
> the keylime verifier giving an I've verified the log up to here and all
> the entries look good token that contains the base PCRs and if there
> are quite a few of these floating around (especially if the log isn't
> always trimmed) I could see the kernel base PCR storage being used to
> ask which is the relevant attestation token I should use to verify the
> rest of the log (or even used to detect nefarious trimming designed to
> hide records).

I have the impression that none the functionality you cited has to be
implemented in the kernel, because the only component one can trust to
verify the integrity of the IMA measurements list is the TPM. Whether
either the kernel or user space retain the measurements is irrelevant.

I believe that the only role of the kernel is to get rid of the
measurements entries as fast as possible (the kernel would act more
like a buffer).

This was actually the intent of my original proposal in
https://github.com/linux-integrity/linux/issues/1 . The idea of staging
(was snapshotting, but Mimi thinks the term is not accurate) is simply
to detach the entire IMA measurement list as fast as possible. Further
read and delete after staging is done without interfering with new
measurements (sure, the detaching of the hash table is not yet as
efficient as I hoped).

Anything that you said about verifying the measurements up to a certain
TPM quote can be implemented in user space without a decrease in
security. I don't see the need to synchronize the trim with the
verification in the kernel.

Roberto


