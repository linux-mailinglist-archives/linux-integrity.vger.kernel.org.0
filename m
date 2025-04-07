Return-Path: <linux-integrity+bounces-5639-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFE9A7DE02
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Apr 2025 14:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7747173084
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Apr 2025 12:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC3B24889B;
	Mon,  7 Apr 2025 12:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qhJZ6oeS"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68101242930
	for <linux-integrity@vger.kernel.org>; Mon,  7 Apr 2025 12:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744029763; cv=none; b=l/8QFyMOAWiwBHOGQhsL9TTd7gklBmlT7MB9Gu0JE/ns618JdyexDsXNv68kTI/bRlZqO7TVP3pCtGOywehZzwvYhHrRu97Mr0zH3k1n4Uf1giV+Ld7aKWVhHSKoRVXP1I5poILlQjY4GdYDQf2+QQEGHNFBnI9yhoyERPxAeHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744029763; c=relaxed/simple;
	bh=rctXt83zXIP6KxDoTjw8wSIbxXWr3qOfeUT6pkhLgpQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=hGPNYmWUxpAHFgfPFh3A9dKsga0fDFeTBTQua/tnRpL1pwDvdJWAT0ZHSmY2iowlJHCnQoQZEVwBBX87moXfSZDzAdZi6Ua441zBuZuX5VJ1m2/MCZOcPB8noWFAykOGET5dTNXofLSCgbLHTg22KY7fnb3yFTKRBgseqOpZOF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=qhJZ6oeS; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250407124238euoutp014e5990c04bf9085dfa96aff571ce3631~0CdM9rcz70652006520euoutp01a
	for <linux-integrity@vger.kernel.org>; Mon,  7 Apr 2025 12:42:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250407124238euoutp014e5990c04bf9085dfa96aff571ce3631~0CdM9rcz70652006520euoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1744029758;
	bh=S5MQ2CqKcA2NrUFZoojUG3FGbumOimUda8wAlinmrVk=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=qhJZ6oeSJCAmhKlZ7GPi8UifuoPo1XKhIGZkwZjA98mkDbKxXsxCHJmARs0J0ZEwX
	 niwFXF74/ChQZinlhCn6OKsw9MGlb/trKSMR9bXTizAvPB2w7ZRK1c8C14ArCRkaT+
	 MsZg4+KxsZIAQegPHxfz09zjfuUdIezIziMLRIK0=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20250407124238eucas1p2b223f89a362856532d1b7ec419ce2e55~0CdMldgaJ1835018350eucas1p2z;
	Mon,  7 Apr 2025 12:42:38 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id DE.0C.20397.E38C3F76; Mon,  7
	Apr 2025 13:42:38 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250407124237eucas1p24a7c88ddf939379e622f261a2f13fa8f~0CdMKf4m80542505425eucas1p2T;
	Mon,  7 Apr 2025 12:42:37 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250407124237eusmtrp19fff47f6ac6db6d47ac4a1f3795d184d~0CdMJyb_73074830748eusmtrp1k;
	Mon,  7 Apr 2025 12:42:37 +0000 (GMT)
X-AuditID: cbfec7f5-ed1d670000004fad-73-67f3c83eb159
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 9D.A5.19654.D38C3F76; Mon,  7
	Apr 2025 13:42:37 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250407124235eusmtip20541764491a44fc45336d4dd36ca10e5~0CdKOqlIf0516105161eusmtip2F;
	Mon,  7 Apr 2025 12:42:35 +0000 (GMT)
Message-ID: <377bfc52-db94-4d76-ab47-8076933bc7e7@samsung.com>
Date: Mon, 7 Apr 2025 14:42:34 +0200
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] KEYS: Add a list for unreferenced keys
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: keyrings@vger.kernel.org, Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	stable@vger.kernel.org, David Howells <dhowells@redhat.com>, Lukas Wunner
	<lukas@wunner.de>, Ignat Korchagin <ignat@cloudflare.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, Paul Moore
	<paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn"
	<serge@hallyn.com>, James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <Z_PATvNUE-qBDEEV@kernel.org>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0xbVRzO6b29vRAKd4WNkwES6mTK021ozjIlLnHmmuwPM7dkInN2cFMm
	UMgtqDMm1m4UoVWbCisUOhhLHHvIowOysQisieXR2TK2FWgZGATpUBi1Nh2rNtLeTfnvO9/j
	fL/fySExkZrYTp6UVTCsTFIiJiLxPsu6PTN3xCt9+bGfj5rtZ3C0qgzgSL2ciMzfjPFR97ck
	arKqANKtawFqbBgBqKPzAg/1zigJNDe7zkMjNosA3e1vJtCaZp5A7qUE5NLpcbQysC5A9nGb
	ALV2zwNkVFiJN+JoT5OWoHsuTfPoNc8HdN/QC7Tj5nv0Wd0YQZsu1xC0tm0I0Bp/AT3xcwdB
	//CjG9CPBu4TtNf0HN1Q3cene70u/J2YvMjXCpmSkx8zbHbuh5FF87Y2QfmVxE+nb7YIFOAM
	rAURJKRy4O99flALIkkR1Q5gnTHIDwki6i8AO/U5nOAF0KobAM8Sk//cxjnhIoC+a7f53MED
	oEtfRYRcQioXLto78BDGqR1Q/WUNn+O3wNHGhTC/lUqGc84GQQjHbvi7uq6HPXHUTqgK3Ahf
	ilGDfKie84cDGBUPnQstvBAmqF2wdqU2XBZBpUFlwMbnPMnwdG8TFgpDKhgBPX+04tzcb8I7
	06qnO8TC5eEeAYcTofU7Dc4FqgFsDczxuIMWQMWS82liH5yxPdmoIzcqXoKd/dkcvR+6TI9A
	iIZUNJxa2cINEQ11fXqMo4XwK5WIc6dCw3DHf7W3xicwLRAbNr2LYdOahk3rGP7vbQX4ZRDP
	VMpLpYx8j4z5JEsuKZVXyqRZBWWlJrDxX63BYd910L7syTIDHgnMAJKYOE64d+xPqUhYKDn1
	GcOWHWcrSxi5GSSQuDhe2DZYJRVRUkkFU8ww5Qz7TOWREdsVvMLVjzLcV9W+yeojK45rlnzm
	3XjvEUn+K8e3pWGmHVf2j1SQg2dTHPKoPM2lA6OPf7FUnz8R/FsGhcGk+uS8enHN/beKGzPL
	cp7XHLtnDQzcXWUzis45ug3taXAtNuXBXuMdVUzlw/TmOv+QrKr/1cSUXw+3694eV6zzi13d
	75dLXkyfUs76orHhnmLPjNN84sG+idOkMTa1EykyZmhx/e5tO2FWJqtaKlEe6ppMWDjV0PIk
	e9nccche+HXC4j22UNn78OCe0S/SLwwsuvPr2Khzjs9fr48uSD18UD+7UOc44Lz1ffZPzjW7
	8epWNinmN8tu17EbqVNjSUfdSb6o81FiXF4k2ZWGsXLJv7q3nJceBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRmVeSWpSXmKPExsVy+t/xe7q2Jz6nG+z+omgx53wLi8W7pt8s
	Ft2vZCwO9Z1itdjYz2Ex+3Qbo8WknxMYLWbOOMFosW79YiaLrXea2Czu3/vJZHHi3DF2i8u7
	5rBZfOh5xGbx4rm0xe1J01ks3u77yW5x/sI5dosFGx8xWsxtOM3mIOLxcfYENo8tK28yeXz4
	GOex7YCqx7XdkR7TJp1i89i0qpPNY8KiA4wePd+TPS6dXcfmsXbvC0aP9/uusnl83iTnMaN9
	G6vH1s+3WQL4o/RsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstS
	i/TtEvQyHp1bxF6wWqbi5u757A2MLRJdjJwcEgImEtf/nmEBsYUEljJKNPwPhYjLSJyc1sAK
	YQtL/LnWxdbFyAVU855R4s7Lu0wgCV4BO4mn59eBNbMIqEh0N3ayQsQFJU7OfAIWFxWQl7h/
	awY7iC0MVL9hww6wGhEBdYm23ztZQYYyCxxklVg2eQM7xIa/jBKX/7xjBKliFhCXuPVkPtg2
	NgFDia63IGdwcnAKaEk0/T7HClFjJtG1tQuqXl6ieets5gmMQrOQHDILyahZSFpmIWlZwMiy
	ilEktbQ4Nz232EivODG3uDQvXS85P3cTIzCdbDv2c8sOxpWvPuodYmTiYDzEKMHBrCTCa3nq
	U7oQb0piZVVqUX58UWlOavEhRlNgaExklhJNzgcmtLySeEMzA1NDEzNLA1NLM2MlcV62K+fT
	hATSE0tSs1NTC1KLYPqYODilGpiE1wscuMF6J/bmvhnrT+5aG70k907SqRzb32z5VVL+DXda
	J01ndDDKOfn53sZwn7kbmAUzKn7eF383b1bBwjeVdrt/cfxJu+ZnYrlcZqP69MgSjdcOUt8U
	vC9dXJlZaMZluD1h478/Mcf+7xVZ8crpauy3kqPrLNvq1jO/3Gy6X1l69a9L3F9M5Sw+rz71
	7P1tTrO7u0PtXgnMc6xibfk8Ncc6U8/m81WjBbetW3/cKjrJHbGqgNFl+wYTlQtPEmpDy8rO
	lNn4py/4FX700x1Zo4o3B9vne5v7/lHmaPPVLE6PNJLtncPnnWumYHcx1rP+8WM3Hgn74rNH
	lbaXaXBwHfw25dANn9tf57aU/T6sxFKckWioxVxUnAgAwQLgHrADAAA=
X-CMS-MailID: 20250407124237eucas1p24a7c88ddf939379e622f261a2f13fa8f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250407102514eucas1p1b297b7b6012a5ece4ccdca8e0e2c7956
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250407102514eucas1p1b297b7b6012a5ece4ccdca8e0e2c7956
References: <20250407023918.29956-1-jarkko@kernel.org>
	<CGME20250407102514eucas1p1b297b7b6012a5ece4ccdca8e0e2c7956@eucas1p1.samsung.com>
	<32c1e996-ac34-496f-933e-a266b487da1a@samsung.com>
	<Z_O1v8awuTeJ9qfS@kernel.org> <Z_PATvNUE-qBDEEV@kernel.org>

On 07.04.2025 14:08, Jarkko Sakkinen wrote:
> On Mon, Apr 07, 2025 at 02:23:49PM +0300, Jarkko Sakkinen wrote:
>> On Mon, Apr 07, 2025 at 12:25:11PM +0200, Marek Szyprowski wrote:
>>> On 07.04.2025 04:39, Jarkko Sakkinen wrote:
>>>> From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
>>>>
>>>> Add an isolated list of unreferenced keys to be queued for deletion, and
>>>> try to pin the keys in the garbage collector before processing anything.
>>>> Skip unpinnable keys.
>>>>
>>>> Use this list for blocking the reaping process during the teardown:
>>>>
>>>> 1. First off, the keys added to `keys_graveyard` are snapshotted, and the
>>>>      list is flushed. This the very last step in `key_put()`.
>>>> 2. `key_put()` reaches zero. This will mark key as busy for the garbage
>>>>      collector.
>>>> 3. `key_garbage_collector()` will try to increase refcount, which won't go
>>>>      above zero. Whenever this happens, the key will be skipped.
>>>>
>>>> Cc: stable@vger.kernel.org # v6.1+ Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
>>> This patch landed in today's linux-next as commit b0d023797e3e ("keys:
>>> Add a list for unreferenced keys"). In my tests I found that it triggers
>>> the following lockdep issue:
>>>
>>> ================================
>>> WARNING: inconsistent lock state
>>> 6.15.0-rc1-next-20250407 #15630 Not tainted
>>> --------------------------------
>>> inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
>>> ksoftirqd/3/32 [HC0[0]:SC1[1]:HE1:SE0] takes:
>>> c13fdd68 (key_serial_lock){+.?.}-{2:2}, at: key_put+0x74/0x128
>>> {SOFTIRQ-ON-W} state was registered at:
>>>     lock_acquire+0x134/0x384
>>>     _raw_spin_lock+0x38/0x48
>>>     key_alloc+0x2fc/0x4d8
>>>     keyring_alloc+0x40/0x90
>>>     system_trusted_keyring_init+0x50/0x7c
>>>     do_one_initcall+0x68/0x314
>>>     kernel_init_freeable+0x1c0/0x224
>>>     kernel_init+0x1c/0x12c
>>>     ret_from_fork+0x14/0x28
>>> irq event stamp: 234
>>> hardirqs last  enabled at (234): [<c0cb7060>]
>>> _raw_spin_unlock_irqrestore+0x5c/0x60
>>> hardirqs last disabled at (233): [<c0cb6dd0>]
>>> _raw_spin_lock_irqsave+0x64/0x68
>>> softirqs last  enabled at (42): [<c013bcd8>] handle_softirqs+0x328/0x520
>>> softirqs last disabled at (47): [<c013bf10>] run_ksoftirqd+0x40/0x68
>> OK what went to -next went there by accident and has been removed,
>> sorry. I think it was like the very first version of this patch.
>>
>> Thanks for informing anyhow!
>
> Testing branch: https://web.git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/log/?h=keys-graveyard
>
> I updated my next this morning so should be fixed soon...

I've just checked that branch and it still triggers lockdep issue. The 
following change is needed to get it fixed:

diff --git a/security/keys/gc.c b/security/keys/gc.c
index 0a3beb68633c..b22dc93eb4b4 100644
--- a/security/keys/gc.c
+++ b/security/keys/gc.c
@@ -302,9 +302,9 @@ static void key_garbage_collector(struct work_struct 
*work)
                 key_schedule_gc(new_timer);
         }

-       spin_lock(&key_graveyard_lock);
+       spin_lock_irqsave(&key_graveyard_lock, flags);
         list_splice_init(&key_graveyard, &graveyard);
-       spin_unlock(&key_graveyard_lock);
+       spin_unlock_irqrestore(&key_graveyard_lock, flags);

         if (unlikely(gc_state & KEY_GC_REAPING_DEAD_2) ||
             !list_empty(&graveyard)) {

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


