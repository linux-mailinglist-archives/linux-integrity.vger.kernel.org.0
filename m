Return-Path: <linux-integrity+bounces-5174-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14190A565F4
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Mar 2025 11:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7494E18992FB
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Mar 2025 10:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5921A20CCFD;
	Fri,  7 Mar 2025 10:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="K2EDHZVs"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAFB1AA1EC;
	Fri,  7 Mar 2025 10:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741345100; cv=none; b=byarnQaQ2DyzlBxgdQOFfI99O214mn3tDm9+LmFS828gn3nOh9qHC7BodrXeO1ViSQPW9Dq9ZBgCUAzYXJLCs68zqqfuC3a/8KRqVRoEaqTzI3XYavU2ElYsoLdAod8kP3cFEo6dJohNcTQijhjDQWtHxw9RahZ//vwLdXzd9RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741345100; c=relaxed/simple;
	bh=I/1IaeKKzQDIqgPXc8s6of6uJlxiLd0PoDcImAiKLus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Em/tJ7cWvZ+mKhw5TyqlSc7y7KzcYEJjqEmUJsBmaXKuPWVViOUmNzRuyp9OpkHIHazke3iqWlnV/dezNn6SxLY1IS7frw228RvNgI5qlzgXGbB7n5vM50KXiiA/ZLhS8Ml+RHBK0zofg+fy1KvynTqzx6Ulp8C9oDJC+TPSsCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=K2EDHZVs; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
	Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=TFkcBFEaZQg44pGkkBpbFWsk3TycqXEL+eCSqbUmgqw=; b=K2EDHZVsfIFeh0WDteEuUfu8Go
	M26LqcGVYjMyxUipjHB0hPT94piM6pW5eJB4Nrz+XUfalNCMBhVrsn82iuLqKyspHqyjO+kzbthpZ
	Sq0eH2ovp/Zjs1FfoFHPx0hB6r8ub/XFjInTwQPmhnmdroTwbCoY5Vn4asm12zYR2AyLM9j1+Qz0/
	dG/+aNgv4qIsIC4ZIftAFIOkLznAcetWdXAO4SZaGyscikwZZmE182HXTugox8zjnaFJZYFO2oeBd
	YKWuOAKV32WCMKxiMgqs9YR9QbfADJf07NcqDSx0A5q6H2yRzJaK6KPkVZEp996Dw/fsJ8sJLLRV8
	I8FOL8aQ==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1tqVPB-00Cu9N-06;
	Fri, 07 Mar 2025 10:58:13 +0000
Date: Fri, 7 Mar 2025 10:58:13 +0000
From: Jonathan McDowell <noodles@earth.li>
To: Jarkko Sakkinen <jarkko@kernel.org>, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tpm: Lazily flush auth session when getting random data
Message-ID: <Z8rRRdwlI6JW8RWF@earth.li>
References: <Z8m8G0RfiRyYGH_t@earth.li>
 <Z8oV9lJ4hsHualcP@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8oV9lJ4hsHualcP@kernel.org>

From: Jonathan McDowell <noodles@meta.com>

Lazy flushing of TPM auth sessions was introduced to speed up IMA
measurments into the TPM. Make use of it in tpm2_get_random as well,
which has the added benefit of not needlessly cleaning up the session
that IMA is using when there are no userspace accesses taking place.

Command trace before for every call:

hwrng (0x00000161): 14 (52965242 ns)
hwrng (0x00000176): 48 (161612432 ns)
hwrng (0x00000165): 10 (2410494 ns)
hwrng (0x0000017B): 117 (70699883 ns)
hwrng (0x0000017B): 117 (70959666 ns)
hwrng (0x00000165): 10 (2756827 ns)

After, with repeated calls showing no setup:

hwrng (0x00000161): 14 (53044582 ns)
hwrng (0x00000176): 48 (160491333 ns)
hwrng (0x00000165): 10 (2408220 ns)
hwrng (0x0000017B): 117 (70695037 ns)
hwrng (0x0000017B): 117 (70994984 ns)
hwrng (0x0000017B): 117 (70195388 ns)
hwrng (0x0000017B): 117 (70973835 ns)

Signed-off-by: Jonathan McDowell <noodles@meta.com>
---
 drivers/char/tpm/tpm2-cmd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index dfdcbd009720..524d802ede26 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -359,7 +359,6 @@ int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
 	} while (retries-- && total < max);
 
 	tpm_buf_destroy(&buf);
-	tpm2_end_auth_session(chip);
 
 	return total ? total : -EIO;
 out:
-- 
2.48.1


