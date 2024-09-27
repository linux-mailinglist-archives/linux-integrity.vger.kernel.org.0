Return-Path: <linux-integrity+bounces-3711-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22163988697
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Sep 2024 15:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52A7A1C20EEC
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Sep 2024 13:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D65F199FD1;
	Fri, 27 Sep 2024 13:54:18 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D29518DF8F
	for <linux-integrity@vger.kernel.org>; Fri, 27 Sep 2024 13:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727445258; cv=none; b=k1+duvEi9OguHkWKQlTS/Us9jqIXq4npbKEX/z9Sgpu9MDGVZ3Zu6aSR9GztJurK135N8ddFitwjwMOMzjRLZAMvGT4bIK3bLTfhadizdebyc1mjCQRULRbpuBL13cifZz6RIWikHeTNEk32abPO+++Wlox7LIlKIzQIpQG8N9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727445258; c=relaxed/simple;
	bh=ET6T710vxAoO/Sk4tACmVr5YF+BD0I/Xx1YK55lhMwE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pdWVpiqJTsp9f2pib6Rs5MWw8FWCxnqbtiI3K6Yz2dnCvyxavwePeSXCuTcpmlGuxTve8zYy/+toiWfkeJNkpyuYyh3BNcxW77zZWiy2o7Ai6qb3g3BtWSNa6CXAxmF/S9ZlvQ9a3jxx3G/zLdYYaty19f4p5gxXmMna+28wERk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4XFWf73Lmdz9v7Hl
	for <linux-integrity@vger.kernel.org>; Fri, 27 Sep 2024 21:34:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 6179D140132
	for <linux-integrity@vger.kernel.org>; Fri, 27 Sep 2024 21:54:07 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwAXx8f3uPZmcTLCAQ--.51442S2;
	Fri, 27 Sep 2024 14:54:06 +0100 (CET)
Message-ID: <d66af0d491f7576c7d865bf6de4da4c83cf0c3ba.camel@huaweicloud.com>
Subject: Re: TPM HMAC (really) bad performance
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>, Jarkko Sakkinen
	 <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>
Date: Fri, 27 Sep 2024 15:53:55 +0200
In-Reply-To: <b8a7b3566e6014ba102ab98e10ede0d574d8930e.camel@huaweicloud.com>
References: <b8a7b3566e6014ba102ab98e10ede0d574d8930e.camel@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwAXx8f3uPZmcTLCAQ--.51442S2
X-Coremail-Antispam: 1UD129KBjvdXoW7XF4fKF18XFyrZw1DKrW3KFg_yoW3GrXE9r
	n5uw1xu39IqrW2g3ZFgw18Zr1fKayUGryFvan7tFn7XryxXr43Jr43GrySqwn7Xa1kta1Y
	kwnIyryxJwsF9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbOxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267
	AKxVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgATBGb2FP0KeQAAsf

On Fri, 2024-09-06 at 14:32 +0200, Roberto Sassu wrote:
> Hi all
>=20
> when running the benchmark on my new component, the Integrity Digest
> Cache, I ran into a serious performance issue.
>=20
> The benchmark is extending a TPM PCR with 12313 entries of the IMA
> measurement list, and calculating the time elapsed for the operation.
>=20
> Without TPM HMAC: 102.8 seconds
>=20
> With TPM HMAC: 1941.71 seconds

Jarkko patch set [1] improved the performance:

404.4 seconds


Still quite slow. We should consider not only the boot performance.
Depending on the use case, IMA can be used after boot and slow down
applications performance.

Thanks

Roberto


[1] https://lore.kernel.org/linux-integrity/20240921120811.1264985-1-jarkko=
@kernel.org/


