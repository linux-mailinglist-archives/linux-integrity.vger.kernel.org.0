Return-Path: <linux-integrity+bounces-3486-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FCC96F45C
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Sep 2024 14:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1CF51C20FB9
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Sep 2024 12:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E8F2745B;
	Fri,  6 Sep 2024 12:32:23 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8378A266AB
	for <linux-integrity@vger.kernel.org>; Fri,  6 Sep 2024 12:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725625942; cv=none; b=s4yES29gmlyD7YpTzr5dMSGYekNgbL0ufk68D+ktdCZdKzDyVsrMFMhoPMTr/fAfH+FpdjLTgmWr99nf7+NasO6uFp90z1NC3HNsAPZDCNWbCpK62hEzbyY66MUDILn14bgdM51H0jI5OW1NnqKJeT7Riol4Pk9w7GpKLO2R9iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725625942; c=relaxed/simple;
	bh=Fi8CIL2bRpHKovIpQrXW5i039gPzEzVybbEZx+2E2Iw=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=A8i9fPw444SfK3UXt+DD/ex8hzf2yU9gyOnTUnatLgrrWKAyzzxpPwEKr8+NJsHE50c9U+WWUb1YGmjFVXj0pcQfUAHHSz1m0jqH2gTZ6DPkbaNZJ27rYPyvA0uHbzjjCu57CaNUFtserg4vKnRklHLrr8OAn61A23B6GHti+hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4X0ZjG28Cvz9v7Jf
	for <linux-integrity@vger.kernel.org>; Fri,  6 Sep 2024 20:07:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 26FB3140485
	for <linux-integrity@vger.kernel.org>; Fri,  6 Sep 2024 20:32:15 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwCXRsdJ9tpmnutjAA--.23111S2;
	Fri, 06 Sep 2024 13:32:14 +0100 (CET)
Message-ID: <b8a7b3566e6014ba102ab98e10ede0d574d8930e.camel@huaweicloud.com>
Subject: TPM HMAC (really) bad performance
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>, Jarkko Sakkinen
	 <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>
Date: Fri, 06 Sep 2024 14:32:05 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwCXRsdJ9tpmnutjAA--.23111S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUU5H7kC6x804xWl14x267AKxVWUJVW8JwAF
	c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26r1j6r4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjc
	xK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
	64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r
	1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwIxGrwCF
	x2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14
	v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY
	67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2
	IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_
	Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUzsqWUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgASBGbaZXoHWgACso

Hi all

when running the benchmark on my new component, the Integrity Digest
Cache, I ran into a serious performance issue.

The benchmark is extending a TPM PCR with 12313 entries of the IMA
measurement list, and calculating the time elapsed for the operation.

Without TPM HMAC: 102.8 seconds

With TPM HMAC: 1941.71 seconds


Do you have already an idea on how to improve the situation?

Thanks

Roberto


