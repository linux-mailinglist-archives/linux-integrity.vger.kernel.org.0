Return-Path: <linux-integrity+bounces-1457-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B198862AF7
	for <lists+linux-integrity@lfdr.de>; Sun, 25 Feb 2024 16:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C56872810B4
	for <lists+linux-integrity@lfdr.de>; Sun, 25 Feb 2024 15:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C360171BB;
	Sun, 25 Feb 2024 15:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aUqbc7RA"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8531B14F98
	for <linux-integrity@vger.kernel.org>; Sun, 25 Feb 2024 15:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708874088; cv=none; b=i5GsPu1gd2H4BCsJueKXVaLbMgvKQeRU3LRW3eQ14hlMRzdqd7XS2BTmuNe7viqkHFQIvSDgM4BoSPYQXTdkAeug2Lxjc+lxOD340YWjgVhFh+atg8EQe7/B7NxveuAnag0iaPUhajxBjmvR6b+tXmx7kZaJ04qvIB4qU55bAaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708874088; c=relaxed/simple;
	bh=sUiTSkzm520oHlE2Wt7zs6qH6fycsoCrqDvhHTq28MA=;
	h=Content-Type:Mime-Version:Date:Message-Id:To:Cc:Subject:From:
	 In-Reply-To; b=DdMwUBKV4PM0Z8uKZxOvwfZ/GbVZsxfMp1t/+NO5xiU68xWzLHKsuHHYHyXVpfNd3DOFDXRgaNalmuq+DS3tR5slJh8L2on6O8Apy4TMV1e4r9GEWmaZCm7ugFzNgjaXR7kSAPFCJgBCWFDH+R1IElh93w5zfHlKfZCLzVEY6w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aUqbc7RA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708874085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=sUiTSkzm520oHlE2Wt7zs6qH6fycsoCrqDvhHTq28MA=;
	b=aUqbc7RAp9WNt82bGho4FrZhJf+CrUDcW10iIYgdvSrVKS92UPoCAMMtYQRdHMg1SRZQud
	h6A2CGuoZnJzydN9Rk6NcvTGG4/y+SCceQKtVxlQHGBVWKVHoIq0X7Y2nC5Bw9FVNfgnfH
	Yo1zqtvfVf1vjqXhJqxglCLS3nPNR80=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661-ndoAgA1OP5e93luYZnYrLw-1; Sun,
 25 Feb 2024 10:14:39 -0500
X-MC-Unique: ndoAgA1OP5e93luYZnYrLw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 40CF53C025D2;
	Sun, 25 Feb 2024 15:14:38 +0000 (UTC)
Received: from localhost (unknown [10.96.134.2])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C25852166AE8;
	Sun, 25 Feb 2024 15:14:29 +0000 (UTC)
Content-Type: multipart/signed;
 boundary=6b0cba759d1417228dbf87ca1baf25c96b6bf983e996b0817fb2b7fe487a;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Sun, 25 Feb 2024 12:14:18 -0300
Message-Id: <CZE9AOYD1M2A.3ABMLN87MYB0A@redhat.com>
To: <dmitry.kasatkin@gmail.com>
Cc: <James.Bottomley@HansenPartnership.com>, <a.mardegan@omp.ru>,
 <dbaryshkov@gmail.com>, <ebiggers@google.com>, <gcwilson@linux.ibm.com>,
 <git@andred.net>, <kgoldman@us.ibm.com>, <linux-integrity@vger.kernel.org>,
 <mjg59@srcf.ucam.org>, <patrick.ohly@intel.com>, <patrick@puiterwijk.org>,
 <petr.vorel@gmail.com>, <roberto.sassu@huawei.com>, <sorenson@redhat.com>,
 <stefanb@linux.ibm.com>, <stephen.smalley.work@gmail.com>,
 <tianjia.zhang@linux.alibaba.com>, <vgoyal@redhat.com>, <vt@altlinux.org>,
 <z.jasinski@samsung.com>, <zohar@linux.ibm.com>
Subject: Re: [ima-evm-utils: PATCH v1 1/1] Change license to
 LGPL-2.0-or-later and GPL-2.0-or-later
From: "Bruno Meneguele" <bmeneg@redhat.com>
In-Reply-To: <9205ed32da8814d8c4d9bde5a03d92c7588f1d9a.1708503094.git.dmitry.kasatkin@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

--6b0cba759d1417228dbf87ca1baf25c96b6bf983e996b0817fb2b7fe487a
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Dmitry (and Mimi, thanks for the heads-up).

Acked-by: Bruno Meneguele <bmeneg@redhat.com>

--=20
Bruno Meneguele
PGP Key: http://bmeneg.com/pubkey.txt


--6b0cba759d1417228dbf87ca1baf25c96b6bf983e996b0817fb2b7fe487a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAABCAAwFiEEdWo6nTbnZdbDmXutYdRkFR+RokMFAmXbWUoSHGJtZW5lZ0By
ZWRoYXQuY29tAAoJEGHUZBUfkaJD8RAH/1/43mr6qkzGxZL5/zgDxgWMUWjb59d+
GfeAW4C8pomlB2SqfEUAUUfeP19/bGM8qVrbNg1RkCeKOOcj2UZ7IQO6E2wLVaps
h6P9BX4HwNPtp2tCUxrcmAIu0XcknW23UockhAWLR6fUbEdd0dzNy5Qb0akDkQIc
y58DOMA3yxg88sZ1LnLufPlD/khz9SJTI7LnObK8uugQWpUwaF010TPuzmbqIEmT
0aRmEMMGF6Fq+Xz4mZn8hPUGYxV5E/JZS/HQ62Xen1tqfQS1CJ4Ua7qI5QKbKvE2
w0wRpobuEy876BAhjVVYnfiRhyWS2r1wJmffgT4LLJUSvq1AUV+akck=
=jeVS
-----END PGP SIGNATURE-----

--6b0cba759d1417228dbf87ca1baf25c96b6bf983e996b0817fb2b7fe487a--


