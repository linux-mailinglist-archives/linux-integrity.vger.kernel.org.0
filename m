Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E4E70EAB8
	for <lists+linux-integrity@lfdr.de>; Wed, 24 May 2023 03:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236211AbjEXBW1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 May 2023 21:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbjEXBW1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 May 2023 21:22:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16DE3E5;
        Tue, 23 May 2023 18:22:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7B586363E;
        Wed, 24 May 2023 01:22:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D20E0C433D2;
        Wed, 24 May 2023 01:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684891345;
        bh=gRN8H4LqvWROxsMb6K8cSUguA4fkgGMJBUi4a1FHt6Q=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=udbtyjuurr1yZ3Q3LSIH32HFyYXa3WYOQ8w91o+g9lXjXeW5iWcKhsph8xqfqIkhf
         oz9iisFBC/Phd7qrkHGQr44Q2GNWTkOar6IS5n4Aer2JWuwAim3V+qTKKyx+0BFIxh
         nyDX2DJp2PpB+sUGiD2wiibOYnVnhRf6Mu99MxAY6vtliYc8iOHoyRg7FNGyedSRk3
         7VjrsGIvSfqV32hGb0MzOYM4Bf8eCTK/97PIh+decegZXjNpu4gqiEkVeyP58JK1DS
         iBq4M7yUjrT4mun7EfPzp3exRUYXF4Ttf/itobTu8BEPbhouYGpiNNM/8FyhryyChQ
         t5Poo0luWoT+w==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 24 May 2023 04:22:19 +0300
Message-Id: <CSU44RXD19SU.26AGW4IZDW9CK@suppilovahvero>
Cc:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <dmitry.kasatkin@gmail.com>, <paul@paul-moore.com>,
        <jmorris@namei.org>, <serge@hallyn.com>, <jlee@suse.com>,
        <kanth.ghatraju@oracle.com>, <konrad.wilk@oracle.com>,
        <keyrings@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] integrity: Enforce digitalSignature usage in the
 ima and evm keyrings
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Mimi Zohar" <zohar@linux.ibm.com>,
        "Eric Snowberg" <eric.snowberg@oracle.com>, <dhowells@redhat.com>,
        <dwmw2@infradead.org>
X-Mailer: aerc 0.14.0
References: <20230522230944.180389-1-eric.snowberg@oracle.com>
 <20230522230944.180389-3-eric.snowberg@oracle.com>
 <ce525793452831d5823bf0548faa0eae2a302f5a.camel@linux.ibm.com>
In-Reply-To: <ce525793452831d5823bf0548faa0eae2a302f5a.camel@linux.ibm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed May 24, 2023 at 1:01 AM EEST, Mimi Zohar wrote:
> On Mon, 2023-05-22 at 19:09 -0400, Eric Snowberg wrote:
> > After being vouched for by a system keyring, only allow keys into the .=
ima
> > and .evm keyrings that have the digitalSignature usage field set.
> >=20
> > Link: https://lore.kernel.org/all/41dffdaeb7eb7840f7e38bc691fbda836635c=
9f9.camel@linux.ibm.com
> > Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> > Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> > Acked-by: Mimi Zohar <zohar@linux.ibm.com>
>
> Jarrko, similarly please update the above tag to Acked-and-test-by.

OK, cool, I'll pick this series, thanks.

BR, Jarkko
