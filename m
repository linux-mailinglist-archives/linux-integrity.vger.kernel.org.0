Return-Path: <linux-integrity+bounces-2473-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BD18C9F37
	for <lists+linux-integrity@lfdr.de>; Mon, 20 May 2024 17:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3FF028306E
	for <lists+linux-integrity@lfdr.de>; Mon, 20 May 2024 15:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59DF41369AF;
	Mon, 20 May 2024 15:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fpvV0n3S"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAE128E7;
	Mon, 20 May 2024 15:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716217342; cv=none; b=G8IiY7ZUmPZ57powT3TJiDcEpcWQE/Y+cx8a0JDx/pmIOy+s1H1kQJ9olOICIBM/qIUZhhRk7owRwFrZrpQRdmsIi9EZ4GLnL4UxcOUJiMV5gFOfLwyLidmwE9FX11N4YxgqMaGL7QcWaVpI1uEmypFAMNj5Ck1oAmZJYOzSkQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716217342; c=relaxed/simple;
	bh=9RS2az84TElMInbtcQQTogk7d6fIdrs3LvcZ6khQz98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pOqlkvk5jXJf1s6qORF0t0m6XtGJW7VeEAtzZCkuHzOHQPhzNndA1269nNXLW18baAQ2FqG50nRMYqUHMsc6FDX/eZOKFrKL14H8ftDJEQGdpqPEg+1Sd2I3SyXBy2PosyzCWgE2o8BVA2FX1x5Veg8XiiqF1ox5H6T/g3xjFYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fpvV0n3S; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=v7UHaYBASGON477WeRkbYfkExvBwpWv5B6NceC3529c=; b=fpvV0n3S49M2CiU5s1d4zgeu/D
	09c7chgt0e7SZHx1SKl57Kwkavj+rOzcqNMQsBngDdxVw4Lnj2tqfIFM5Vglng9KGvNj3tynUqO/W
	I6IzicAjOXT16P8KjwBIXPZEH/CsEIhM18snHX+ph2fMOpbVJk4oqy39N2bIWC5vFUEghZ7QsQ1hi
	hcwrABCKfkfnhL0QUtJ3WdnHPD79gMQjVnJ75Hu9uNYWqDdRmnOZ67E1gW1YweFqxKs11vyTVzghZ
	gPqkZedsAnVVGJs7XlLaRKCsNgEt/6CFPDbbd2XVca48y19gdnpLO5C+8YrFNN74B/Qaqq2AC0/J/
	y0YtFpCw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s94Wm-0000000EmZ7-3FjD;
	Mon, 20 May 2024 15:02:16 +0000
Date: Mon, 20 May 2024 08:02:16 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Eric Wheeler <linux-integrity@lists.ewheeler.net>,
	Mike Snitzer <snitzer@kernel.org>, Milan Broz <gmazyland@gmail.com>,
	dm-devel@lists.linux.dev, linux-integrity@vger.kernel.org
Subject: Re: [PATCH] dm-integrity: set discard_granularity to logical block
 size
Message-ID: <Zktl-DSFXiNQg7K5@infradead.org>
References: <d015c396-d686-48b1-1460-c8e1b18f4c4c@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d015c396-d686-48b1-1460-c8e1b18f4c4c@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, May 20, 2024 at 04:48:31PM +0200, Mikulas Patocka wrote:
> dm-integrity could set discard_granularity lower than the logical block
> size. This could result in failures when sending discard requests to
> dm-integrity. This patch fixes discard_granularity.

What kernel was this reported on?  For current mainline,
blk_validate_limits should ensure that the discard_granularity is
floored by the logical block size.


