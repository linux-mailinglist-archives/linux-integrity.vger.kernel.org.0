Return-Path: <linux-integrity+bounces-9618-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHOwL3W/DmrXBwYAu9opvQ
	(envelope-from <linux-integrity+bounces-9618-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 21 May 2026 10:16:53 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC135A0E38
	for <lists+linux-integrity@lfdr.de>; Thu, 21 May 2026 10:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9FCEE302ACE6
	for <lists+linux-integrity@lfdr.de>; Thu, 21 May 2026 08:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0BE261B91;
	Thu, 21 May 2026 08:15:23 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389ED2853E0;
	Thu, 21 May 2026 08:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779351323; cv=none; b=kV7NIoBbQb7/ainITT8MxzVm6SbB4bITSoEFcAJa+brPxzw+g2rlxUmuRTRZYxb1enAEhxTWSHYmnJiLwAL8dj0fr90uU1iECTXcVXOzUsh69mxtFsjoWKdEIR/Vrr68Tyujey04YPKey2q58Gy5iXgR02qjqLioZnr1rsKJEcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779351323; c=relaxed/simple;
	bh=EWQ0CX0ltnO0DbWI+6/zlhkgYo4oLRVUk3SuwSeNXoA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sA09THlYPXtNkhnA0YoUeRhsK0SIVJXdc4NahorpZ9Ea1vC8ixDuIwPeIOzs7AgaYvDmoWSvH5dfMv+oEMOX8up1XdPCpkep2yakFHgq0fjVItX0UDuwT20i5QywZMyhVZysstmo8UCgHcnxzWgir1vGt+s2c2WdyApdDVTcY1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.235])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gLgfL6JnQzwb6L;
	Thu, 21 May 2026 15:54:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 03FEC40573;
	Thu, 21 May 2026 15:59:00 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwDHeKIyuw5qLFiOAQ--.43055S2;
	Thu, 21 May 2026 08:58:51 +0100 (CET)
Message-ID: <97d4e0989fb84ed85475920c3e00320a45c3afda.camel@huaweicloud.com>
Subject: Re: [PATCH v5 04/13] ima: Introduce per binary measurements list
 type binary_runtime_size value
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Mimi Zohar <zohar@linux.ibm.com>, corbet@lwn.net,
 skhan@linuxfoundation.org,  dmitry.kasatkin@gmail.com,
 eric.snowberg@oracle.com, paul@paul-moore.com,  jmorris@namei.org,
 serge@hallyn.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	gregorylumen@linux.microsoft.com, chenste@linux.microsoft.com, 
	nramas@linux.microsoft.com, Roberto Sassu <roberto.sassu@huawei.com>
Date: Thu, 21 May 2026 09:58:39 +0200
In-Reply-To: <b7f97a0a3b79b72a014d12514febc338d1ecd038.camel@linux.ibm.com>
References: <20260429160319.4162918-1-roberto.sassu@huaweicloud.com>
	 <20260429160319.4162918-5-roberto.sassu@huaweicloud.com>
	 <b7f97a0a3b79b72a014d12514febc338d1ecd038.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwDHeKIyuw5qLFiOAQ--.43055S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tFy7AryfJw1xXF1UXryUGFg_yoW8JFWkpF
	WfZw1Fkr4kXa4xGrWDKa97WFWru34rJ34Dtr4DWF1kuFs5A34Fy3WUKF1rKFZ09r1kta4U
	Zw40gr4fA3WYvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFk
	u4UUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAABGoNmbsKMgACs6
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9618-lists,linux-integrity=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	FREEMAIL_TO(0.00)[linux.ibm.com,lwn.net,linuxfoundation.org,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[roberto.sassu@huaweicloud.com,linux-integrity@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,huawei.com:email,huaweicloud.com:mid]
X-Rspamd-Queue-Id: 3AC135A0E38
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 2026-05-20 at 22:06 -0400, Mimi Zohar wrote:
> On Wed, 2026-04-29 at 18:03 +0200, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> >=20
> > Make binary_runtime_size as an array, to have separate counters per bin=
ary
> > measurements list type. Currently, define the BINARY type for the exist=
ing
> > binary measurements list.
> >=20
> > Introduce ima_update_binary_runtime_size() to facilitate updating a
> > binary_runtime_size value with a given binary measurement list type.
> >=20
> > Also add the binary measurements list type parameter to
> > ima_get_binary_runtime_size(), to retrieve the desired value. Retrievin=
g
> > the value is now done under the ima_extend_list_mutex, since there can =
be
> > concurrent updates.
> >=20
> > No functional change (except for the mutex usage, that fixes the
> > concurrency issue): the BINARY array element is equivalent to the old
> > binary_runtime_size.
>=20
> The patch is really clear and well written, but I don't see a concurrency=
 issue
> requiring taking the ima_extend_list_mutex at least in this patch.

binary_runtime_size is not an atomic variable. It is updated under the
ima_extend_list_mutex lock in ima_add_digest_entry(). The same lock
must be taken on the reader side, ima_get_binary_runtime_size().

Roberto


