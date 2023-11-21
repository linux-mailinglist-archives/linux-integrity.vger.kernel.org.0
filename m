Return-Path: <linux-integrity+bounces-145-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8917F2B5E
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Nov 2023 12:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDACF282601
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Nov 2023 11:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2A4482DF;
	Tue, 21 Nov 2023 11:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-integrity@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F8B122;
	Tue, 21 Nov 2023 03:03:08 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id A91292800B3E2;
	Tue, 21 Nov 2023 12:03:05 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id A3FF336B3A; Tue, 21 Nov 2023 12:03:05 +0100 (CET)
Date: Tue, 21 Nov 2023 12:03:05 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Rob Herring <robh@kernel.org>
Cc: Lino Sanfilippo <LinoSanfilippo@gmx.de>, devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>, linux-integrity@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 2/3] dt-bindings: tpm: Convert IBM vTPM bindings to DT
 schema
Message-ID: <20231121110305.GB22827@wunner.de>
References: <cover.1700555862.git.lukas@wunner.de>
 <fc5c973d30df7ece297e19edad19ffe86378b6b1.1700555862.git.lukas@wunner.de>
 <170056423981.1245464.10395498560154249075.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170056423981.1245464.10395498560154249075.robh@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Nov 21, 2023 at 03:57:21AM -0700, Rob Herring wrote:
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):

Your bot hasn't read the cover letter, which discusses those errors:

https://lore.kernel.org/linux-devicetree/cover.1700555862.git.lukas@wunner.de/

