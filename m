Return-Path: <linux-integrity+bounces-2085-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD1D8A3B6E
	for <lists+linux-integrity@lfdr.de>; Sat, 13 Apr 2024 09:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4A0D1C20D2D
	for <lists+linux-integrity@lfdr.de>; Sat, 13 Apr 2024 07:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1A538FA3;
	Sat, 13 Apr 2024 07:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=michael.haener@siemens.com header.b="HozHQ1Yr"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96613838C
	for <linux-integrity@vger.kernel.org>; Sat, 13 Apr 2024 07:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712992616; cv=none; b=VpV/lB+VLDnQ9plkvP4M0CLLtTAaxFvQ3GWz8I5KmHrVHouNI6uKZU3b3Z9JY36WTK0cQqDnU6QjZ1ylwUyeJh23cKW34g2tAUf4HFhbOWu4gRJRM5pC8gXZFdETONRySPWDbyHQMvbP200yM7sAklVevfwyyRey1WJWa/OTL/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712992616; c=relaxed/simple;
	bh=h+jXI0oeBS8n98NMxvX0ZNK9OanOZVaWfhf9F7zYh20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lk3jOQaiEKKndq1UTGWc2kD18KSRje47QGPYKfTveVMTMPyCHD505cuqpKgFc1MYMnrqicAB7XbWJSm2jjyUJ6dRK5cFZ+BKrWJhHEje+R8Io+Ne2eZNzJ0vULCDAHWmOJEUXlUBzZGyAkwAj7ZDWMWds2VSRCHHuP4aXURZTU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=michael.haener@siemens.com header.b=HozHQ1Yr; arc=none smtp.client-ip=185.136.65.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 20240413071646510cdec554b6d2a9e4
        for <linux-integrity@vger.kernel.org>;
        Sat, 13 Apr 2024 09:16:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=michael.haener@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=QyM1wgxijDrCMszk9wY5F2yipXafY8cejQEdgl4Lh14=;
 b=HozHQ1YreXAXjF1NAGUC2PjRvs1Y8ZdzsE1jOMDCElI5dCgL9/UnE6bzEliL3LlJJkPsbn
 a3xbOYh8Ycd+PdGAEdxh95X96WJG9WI+BEN3hGR9oJjAxbqYSz9TPsHzE6iXhN1Yt1f8uOLm
 TybqAFEOkCdvnA0LXOF/mWgd6O924=;
From: "M. Haener" <michael.haener@siemens.com>
To: linux-integrity@vger.kernel.org
Cc: Michael Haener <michael.haener@siemens.com>,
	linux-kernel@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>
Subject: [PATCH 2/2] dt-bindings: tpm: Add st,st33ktpm2xi2c to TCG TIS binding
Date: Sat, 13 Apr 2024 09:15:07 +0200
Message-ID: <20240413071621.12509-3-michael.haener@siemens.com>
In-Reply-To: <20240413071621.12509-1-michael.haener@siemens.com>
References: <20240413071621.12509-1-michael.haener@siemens.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-664519:519-21489:flowmailer

From: Michael Haener <michael.haener@siemens.com>

Add the ST chip st33ktpm2xi2c to the supported compatible strings of the
TPM TIS I2C schema. The Chip is compliant with the TCG PC Client TPM
Profile specification.

For reference, a datasheet is available at:
https://www.st.com/resource/en/data_brief/st33ktpm2xi2c.pdf

Reviewed-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
Signed-off-by: Michael Haener <michael.haener@siemens.com>
---
 Documentation/devicetree/bindings/tpm/tcg,tpm-tis-i2c.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/tpm/tcg,tpm-tis-i2c.yaml b/Documentation/devicetree/bindings/tpm/tcg,tpm-tis-i2c.yaml
index 3ab4434b7352..af7720dc4a12 100644
--- a/Documentation/devicetree/bindings/tpm/tcg,tpm-tis-i2c.yaml
+++ b/Documentation/devicetree/bindings/tpm/tcg,tpm-tis-i2c.yaml
@@ -32,6 +32,7 @@ properties:
           - enum:
               - infineon,slb9673
               - nuvoton,npct75x
+              - st,st33ktpm2xi2c
           - const: tcg,tpm-tis-i2c
 
       - description: TPM 1.2 and 2.0 chips with vendor-specific I²C interface
-- 
2.44.0


