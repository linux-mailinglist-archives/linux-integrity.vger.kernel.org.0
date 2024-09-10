Return-Path: <linux-integrity+bounces-3507-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 111AF973A93
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Sep 2024 16:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 439461C21BA2
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Sep 2024 14:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0156F1957F9;
	Tue, 10 Sep 2024 14:51:50 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDC12BB05;
	Tue, 10 Sep 2024 14:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725979909; cv=none; b=lmr6t2/ah/qexSmF8NfGZbHm0hvDbqLbFSDM7j7+nYK5JBbH8DTDW8HErv/Psj1KsGUlUyJzakKOjhRsGdzDMRr1Ohb5xMCrZlYGFmThzyBFt4xruA/t/ctTGUn2TvdES75Yi2CDpH1hTGZ7asT2Au95Mt6Qix636waT0mMN4Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725979909; c=relaxed/simple;
	bh=uvwLVFWov70fflU6oUvnlHd70Ue9hF5ps0SZxvsS9sk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QlumY7V+qJTQs+HdxjtdorbYSN+c6iTvxfMv07rfamYdMYhUAz186+Uq6v2UHmNZaRzv+QCMdRtZgXe1OssjUEP3P52Vw9sqQ8sWnqrqvjF3exYkI9fC0B6iNNdyVP6iKBYsLxEm49I9HDU+KUTYiyrfijs83CKXizrtd+gHayc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4X35kf0zP6z9v7NN;
	Tue, 10 Sep 2024 22:32:10 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 1F6A7140604;
	Tue, 10 Sep 2024 22:51:35 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwDXOMntXOBmIBCoAA--.53684S2;
	Tue, 10 Sep 2024 15:51:34 +0100 (CET)
Message-ID: <6c7e34b65d73e9fa2ba0fd39b357b9eb42ee0449.camel@huaweicloud.com>
Subject: Re: [PATCH v2 00/14] KEYS: Add support for PGP keys and signatures
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Jonathan McDowell <noodles@earth.li>
Cc: dhowells@redhat.com, dwmw2@infradead.org, herbert@gondor.apana.org.au, 
 davem@davemloft.net, linux-kernel@vger.kernel.org,
 keyrings@vger.kernel.org,  linux-crypto@vger.kernel.org,
 zohar@linux.ibm.com,  linux-integrity@vger.kernel.org, Roberto Sassu
 <roberto.sassu@huawei.com>,  adrian@suse.de, ro@suse.de
Date: Tue, 10 Sep 2024 16:51:22 +0200
In-Reply-To: <a9502b8097841c36ca13871b22149eadd3fde355.camel@huaweicloud.com>
References: <20240818165756.629203-1-roberto.sassu@huaweicloud.com>
	 <ZsNf1VdfkHqD8R4Q@earth.li>
	 <f142b1c4e662d4701a2ab67fa5fc839ab7109e5e.camel@huaweicloud.com>
	 <ZsSkTs4TFfx2pK8r@earth.li>
	 <a9502b8097841c36ca13871b22149eadd3fde355.camel@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwDXOMntXOBmIBCoAA--.53684S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tr4DurW5KF45Jr45Wry8Xwb_yoW8KF1Dpa
	y8GF15AFWkJw1SyFn2k3WUurWYy39rJFy5Wwn8A3s5Crn0qFyF9F1xKF4Y9as8Wr4fCw1j
	vrW3Jay3W3sYyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQACBGbfqvQMJwAAsL

On Tue, 2024-09-10 at 16:36 +0200, Roberto Sassu wrote:
> On Tue, 2024-08-20 at 15:12 +0100, Jonathan McDowell wrote:
> > On Mon, Aug 19, 2024 at 05:15:02PM +0200, Roberto Sassu wrote:
> > > On Mon, 2024-08-19 at 16:08 +0100, Jonathan McDowell wrote:
> > > > On Sun, Aug 18, 2024 at 06:57:42PM +0200, Roberto Sassu wrote:
> > > > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > > >=20
> > > > > Support for PGP keys and signatures was proposed by David long ti=
me ago,
> > > > > before the decision of using PKCS#7 for kernel modules signatures
> > > > > verification was made. After that, there has been not enough inte=
rest to
> > > > > support PGP too.
> > > >=20
> > > > You might want to update the RFC/bis references to RFC9580, which w=
as
> > > > published last month and updates things.
> > >=20
> > > Yes, makes sense (but probably isn't too much hassle to support more
> > > things for our purposes?)
> >=20
> > I'm mostly suggesting that the comments/docs point to the latest
> > standard rather than the draft version, not changing to support the new
> > v6 keys.
> >=20
> > > > Also, I see support for v2 + v3 keys, and this doesn't seem like a =
good
> > > > idea. There are cryptographic issues with fingerprints etc there an=
d I
> > > > can't think of a good reason you'd want the kernel to support them.=
 The
> > > > same could probably be said of DSA key support too.
> > >=20
> > > Uhm, if I remember correctly I encountered some old PGP keys used to
> > > verify RPM packages (need to check). DSA keys are not supported, sinc=
e
> > > the algorithm is not in the kernel.
> >=20
> > I would question the benefit gained from using obsolete key/signature
> > types for verification (I was involved in the process of Debian droppin=
g
> > them back in *2010* which was later than it should have been). Dropping
> > the code for that path means a smaller attack surface/maintenance
> > overhead for something that isn't giving a benefit.
>=20
> Removed support for v3 PGP signatures... but that broke openSUSE
> Tumbleweed.
>=20
> [  295.837602] PGPL: Signature packet with unhandled version 3

To add more context, this patch set adds the ability to the kernel to
verify the PGP signature of RPM packages against Linux distributions
PGP keys.

The purpose of this is to verify the authenticity of such RPM packages,
and to extract from them file digests, which are in turn used as
reference values for integrity check (appraisal) with IMA.

Roberto


