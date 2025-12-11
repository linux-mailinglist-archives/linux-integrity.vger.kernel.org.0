Return-Path: <linux-integrity+bounces-7908-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F10CACB5786
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Dec 2025 11:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F0E55300AFC4
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Dec 2025 10:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15472F7471;
	Thu, 11 Dec 2025 10:13:07 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02E63B8D5E;
	Thu, 11 Dec 2025 10:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765447987; cv=none; b=AnvmdgTu9TWgl41HADPVteLkTvR9X+h6VLJSv8rDpYeQhr3AQfrwUKNpagFLJWwwic3SjZjbldHJNZB/b6D1OCh657rvLh+BNU9ct47oAGslizsUtPHzzuYlvbss+2IQIAAScilY6zVa9H1BOrtrVIdvG1BsGzHw63IaCNBCOic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765447987; c=relaxed/simple;
	bh=t+/kScX1AAd2P1lLt02M5+1JKbZX/1f4xVivXKYWicQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XO2JyLt4hGx15hcpPfTErfChku12pCcAM6Tq33Sc4Buqfc0SBFYVqvsSVlt/9Xe6XQdF6ROdD5+U7h5BLcYIX7Dp+6LF4hhuzmOaRRkCf/9pIf4dKLAvT3RfnGgMuguxFeZFtdE2E5a+A9JUAqh+GWPqTgXscvGKR+w2RQWkFDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.196])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dRnxw5GbjzsjRw;
	Thu, 11 Dec 2025 17:55:00 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 4614A40567;
	Thu, 11 Dec 2025 17:56:35 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwAHXjJIlTppzX67AA--.17419S2;
	Thu, 11 Dec 2025 10:56:34 +0100 (CET)
Message-ID: <d7418d0afa696b8da67e4f25fd0dc1b9d6fd908f.camel@huaweicloud.com>
Subject: Re: [RFC][PATCH] ima: Add support for staging measurements for
 deletion
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Gregory Lumen <gregorylumen@linux.microsoft.com>
Cc: corbet@lwn.net, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, 
 eric.snowberg@oracle.com, paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com,  linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
  linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
 chenste@linux.microsoft.com, nramas@linux.microsoft.com, Roberto Sassu
 <roberto.sassu@huawei.com>
Date: Thu, 11 Dec 2025 10:56:22 +0100
In-Reply-To: <207fd6d7-53c-57bb-36d8-13a0902052d1@linux.microsoft.com>
References: <20251209101725.3680225-1-roberto.sassu@huaweicloud.com>
	 <207fd6d7-53c-57bb-36d8-13a0902052d1@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwAHXjJIlTppzX67AA--.17419S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGr1ktrW5uF4kCF48KF1rZwb_yoW5Wry5pa
	s3G34UGr4qqr4jvw18Jw1I934Svw48tr45Wr1kKw10k34Yg3sa9a4F9a45uFy29rs3tF15
	XF4DXryjkan8AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQATBGk5YO8MtwADsx

On Wed, 2025-12-10 at 11:12 -0800, Gregory Lumen wrote:
> Roberto,
>=20
> The proposed approach appears to be workable. However, if our primary goa=
l=20
> here is to enable UM to free kernel memory consumed by the IMA log with a=
n=20
> absolute minimum of kernel functionality/change, then I would argue that=
=20
> the proposed Stage-then-delete approach still represents unnecessary=20
> complexity when compared to a trim-to-N solution. Specifically:
>=20
> - Any functional benefit offered through the introduction of a staged=20
> measurement list could be equally achieved in UM with a trim-to-N solutio=
n=20
> coupled with the proposed ima_measure_users counter for access locking.

Ok, let's quantify the complexity of each solution. Let's assume that
the IMA measurements list has M entries and you want to trim at N < M.

Staging:

1st. trim at N

(kernel)
1. list lock (write side) -> list replace (swap the heads) -> list unlock
2. read M -> file (file contains 0..M)
3. for each 0..M -> delete entry

(user)
1. for each 0..N in file -> replay PCR
2. trim at N (keep N + 1..M)


2nd. trim at O

(kernel)
1. list lock -> list replace (swap the heads) -> list unlock
2. read P -> file (file contains N + 1..P)
3. for each M + 1..P -> delete entry

(user)
1. for each N + 1..O in file -> replay PCR
2. trim at O (keep O + 1..P)



Trimming:

1st. trim at N

(kernel)
1. list lock (read side) -> for each 0..M -> read in file (file now contain=
s 0..M) -> list unlock

(user)
1. for each 0..N -> replay PCR
2. discard N + 1..M

(kernel)

1. list lock (write side) -> for each 0..N -> trim -> list unlock


2nd. trim at O

(kernel)
1. list lock (read side) -> for each N + 1..P -> read in file (file now con=
tains N + 1..P) -> list unlock

(user)
1. for each N + 1..O -> replay PCR
2. discard O + 1..P

(kernel)

1. list lock (write side) -> for each N + 1..O -> trim -> list unlock


You can try to optimize it a bit by prematurely ending the reading
before M and P, and by replaying the PCR on a partial buffer.


But still:

I just swap list heads in the hot path (still need to do the same for
the hash table, postponed to later), and do the free later once there
is no contention with new measurements.

In your case you are taking the lock and walking the list two times,
once as a reader and once as a writer, and discarding measurements in
user space that you already have.

I think your solution is more complex.

> - There exists a potential UM measurement-loss race condition introduced=
=20
> by the staging functionality that would not exist with a trim-to-N=20
> approach. (Occurs if a kexec call occurs after a UM agent has staged=20
> measurements for deletion, but has not completed copying them to=20
> userspace). This could be avoided by persisting staged measurements acros=
s=20
> kexec calls at the cost of making the proposed change larger.

The solution is to coordinate the staging with kexec in user space.


Roberto


