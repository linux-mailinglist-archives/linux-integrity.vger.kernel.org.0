Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2505A712B
	for <lists+linux-integrity@lfdr.de>; Wed, 31 Aug 2022 00:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbiH3WzC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 30 Aug 2022 18:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbiH3Wyw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 30 Aug 2022 18:54:52 -0400
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 396BF128
        for <linux-integrity@vger.kernel.org>; Tue, 30 Aug 2022 15:54:46 -0700 (PDT)
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id E3E4D72C90B;
        Wed, 31 Aug 2022 01:54:45 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id ACFFB4A470D;
        Wed, 31 Aug 2022 01:54:45 +0300 (MSK)
Date:   Wed, 31 Aug 2022 01:54:45 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, Petr Vorel <pvorel@suse.cz>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [RFC PATCH ima-evm-utils 08/11] Deprecate use of OpenSSL 3
 "engine" support
Message-ID: <20220830225445.nf6rftpkfv4tgp7h@altlinux.org>
References: <20220830005936.189922-1-zohar@linux.ibm.com>
 <20220830005936.189922-9-zohar@linux.ibm.com>
 <20220830030353.lwggzfsqmalpznoy@altlinux.org>
 <30cc0eab23501c33ab3d2a8e2a6548b92ce9a127.camel@linux.ibm.com>
 <20220830205254.w6cahikybwzmxwkx@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20220830205254.w6cahikybwzmxwkx@altlinux.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Mimi,

On Tue, Aug 30, 2022 at 11:52:54PM +0300, Vitaly Chikunov wrote:
> On Tue, Aug 30, 2022 at 07:46:40AM -0400, Mimi Zohar wrote:
> > On Tue, 2022-08-30 at 06:03 +0300, Vitaly Chikunov wrote:
> > We need to move away from OpenSSL engine support towards providers.
> 
> Perhaps they will remove engines (it's not certain) in openssl4,
> but how many years will pass before that? I don't see why we should
> hurry in that.

https://www.openssl.org/policies/releasestrat.html
  Version 3.0 will be supported until 2026-09-07 (LTS).

So all that time there will be engines support, even if they decide to
remove it in next major release. So it doesn't look like we need to
delete it ASAP.

Thanks,

