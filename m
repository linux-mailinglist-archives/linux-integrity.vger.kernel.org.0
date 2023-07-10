Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72E9074E073
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Jul 2023 23:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjGJVvT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 10 Jul 2023 17:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjGJVvT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 10 Jul 2023 17:51:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3044F120;
        Mon, 10 Jul 2023 14:51:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA91C61219;
        Mon, 10 Jul 2023 21:51:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4111DC433C8;
        Mon, 10 Jul 2023 21:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689025877;
        bh=Jua7zun8YvUI0vC/2wkDLhzbAsFN3rJjtiTS/0WM4zc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=moAl2AYrv8KBcbW8tp91lv0R1iZZfkWNS4yREMcet0UNHeaURiPPGpD1KJoOj0j3f
         amSynT+A7W9JAsb9lBRIBWrOEVmLmm9beOZ3UwzB4s4uL8gcAhI9asBSpom4MCI4M6
         rWDqZoixR/yJcg0LLFqKNQsACiacoNQ8ssZ+4oGvpCpnKbcp7X+y8BEL63w4KZll9q
         W5wLH+ObbIPwJfS7FELtQMDSb5IKDNPQcKWoakgd9ZI7BTxTZ2IRSJSVhhhrfn36bV
         gPJcX2rRylrw/USSd620nQa4rDU2iGPmlULx7c+O0hICMhTAvOZ8tiTxaLPsIBIY8D
         ZSNDdAeFf5gFQ==
Message-ID: <31d20085105784a02b60f11d46f2c7fec4d3aa0a.camel@kernel.org>
Subject: Re: [PATCH v2 1/2] tpm/tpm_tis: Disable interrupts for Framework
 Laptop Intel 12th gen
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Christian Hesse <list@eworm.de>, linux-integrity@vger.kernel.org
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        Peter Huewe <peterhuewe@gmx.de>,
        Christian Hesse <mail@eworm.de>, stable@vger.kernel.org,
        roubro1991@gmail.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 11 Jul 2023 00:51:12 +0300
In-Reply-To: <bd0587e16d55ef38277ab1f6169909ae7cde3542.camel@kernel.org>
References: <20230710133836.4367-1-mail@eworm.de>
         <20230710142916.18162-1-mail@eworm.de>
         <20230710231315.4ef54679@leda.eworm.net>
         <bd0587e16d55ef38277ab1f6169909ae7cde3542.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2023-07-11 at 00:29 +0300, Jarkko Sakkinen wrote:
> On Mon, 2023-07-10 at 23:13 +0200, Christian Hesse wrote:
> > Christian Hesse <mail@eworm.de> on Mon, 2023/07/10 16:28:
> > > This device suffer an irq storm, so add it in tpm_tis_dmi_table to
> > > force polling.
> >=20
> > Uh, looks like this is not quite right. The product version specifies t=
he CPU
> > "level" across generations (for example "i5-1240P" vs. "i7-1260P" vs.
> > "i7-1280P"). So I guess we should match on the product name instead...
> >=20
> > I will send an updated set of patches. Would be nice if anybody could v=
erify
> > this...
>=20
> OK, this good to hear! I've been late with my pull request (past rc1)
> because of kind of conflicting timing with Finnish holiday season and
> relocating my home office.
>=20
> I'll replace v2 patches with v3 and send the PR for rc2 after that.
> So unluck turned into luck this time :-)
>=20
> Thank you for spotting this!

Please, sanity check before I send the PR for rc2:

https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/

BR, Jarkko
