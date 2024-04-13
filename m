Return-Path: <linux-integrity+bounces-2092-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0628A3C53
	for <lists+linux-integrity@lfdr.de>; Sat, 13 Apr 2024 12:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 686A5B21C16
	for <lists+linux-integrity@lfdr.de>; Sat, 13 Apr 2024 10:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E241831A94;
	Sat, 13 Apr 2024 10:51:19 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AAA3EA96;
	Sat, 13 Apr 2024 10:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713005479; cv=none; b=RojA6T9/7m7Ivt6Z0T5S1DHighyN0cupGKJYX9KoKBICQJ6FO838ynk0SWTSOezqReyw5z6X1XXbJreUBNerZrkd+jU5pH9qD1Ok62dUHNg3JHgK2fMAGP0Gc8wvxISfiIbD4TunPMUHmyJNZoORJnVcnKlbQTCpHs3tWo0R7II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713005479; c=relaxed/simple;
	bh=8bpdfCe2nuq6dKsz2FLSG+VUZG2U5J6jqaUpYbF9eW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jaOei+zXTLA8DQTGekgkyaoz4E2GLDwegenqG7qeYKvDZKU4DwjYgWcUZ2oob/FqTsPinFUrKPPuqyklkfmZNXmeVD7i1yTysPAEMWRcBDa+I1HX680awsrDFspKHRB8/Luv+oA/UBen1isrCwLrYxm/RYGf25o0FmGlDXm/WcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 4A4771029D24D;
	Sat, 13 Apr 2024 12:51:15 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 2C13048440; Sat, 13 Apr 2024 12:51:15 +0200 (CEST)
Date: Sat, 13 Apr 2024 12:51:15 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: "M. Haener" <michael.haener@siemens.com>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>
Subject: Re: [PATCH 2/2] dt-bindings: tpm: Add st,st33ktpm2xi2c to TCG TIS
 binding
Message-ID: <ZhpjozjbeWrb0OTl@wunner.de>
References: <20240413071621.12509-1-michael.haener@siemens.com>
 <20240413071621.12509-3-michael.haener@siemens.com>
 <8c13a349-a721-44d3-9e23-2e01f4c2ca4d@linaro.org>
 <Zhpb2URMxuoilKAZ@wunner.de>
 <3d08cf54-f58f-446f-977e-21ba65986924@linaro.org>
 <ZhpfwaIUc0HpfZP1@wunner.de>
 <889ca65c-c9c7-4658-9c34-5d89774218cc@linaro.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <889ca65c-c9c7-4658-9c34-5d89774218cc@linaro.org>

On Sat, Apr 13, 2024 at 12:43:38PM +0200, Krzysztof Kozlowski wrote:
> On 13/04/2024 12:34, Lukas Wunner wrote:
> > The other patch just adds an entry to of_tis_i2c_match[] in the driver,
> > pretty unspectacular:
> > 
> > https://lore.kernel.org/all/20240413071621.12509-2-michael.haener@siemens.com/
> 
> Then why is it needed?

The binding requires two entries in the compatible string used in the DT,
the chip name followed by the generic string:

        items:
          - enum:
              - infineon,slb9673
              - nuvoton,npct75x
          - const: tcg,tpm-tis-i2c

This allows us to deal with device-specific quirks, should they pop up
(e.g. special timing requirements, hardware bugs).  We don't know in
advance if they will be discovered, but if they are, it's cumbersome
to determine after the fact which products (and thus DTs) are affected.
So having the name of the actual chip used on the board has value.

Thanks,

Lukas

