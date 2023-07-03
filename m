Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C102745510
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Jul 2023 07:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjGCFwm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 3 Jul 2023 01:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjGCFwm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 3 Jul 2023 01:52:42 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057C1A4
        for <linux-integrity@vger.kernel.org>; Sun,  2 Jul 2023 22:52:40 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QvZny4Dynz4wb5;
        Mon,  3 Jul 2023 15:52:38 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Nayna Jain <nayna@linux.ibm.com>
Cc:     Andrew Donnellan <ajd@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Russell Currey <ruscur@russell.cc>,
        Nageswara R Sastry <rnsastry@linux.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>
In-Reply-To: <20230608120444.382527-1-nayna@linux.ibm.com>
References: <20230608120444.382527-1-nayna@linux.ibm.com>
Subject: Re: [PATCH v2] security/integrity: fix pointer to ESL data and its size on pseries
Message-Id: <168836201899.50010.16718457510538394042.b4-ty@ellerman.id.au>
Date:   Mon, 03 Jul 2023 15:26:58 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 08 Jun 2023 08:04:44 -0400, Nayna Jain wrote:
> On PowerVM guest, variable data is prefixed with 8 bytes of timestamp.
> Extract ESL by stripping off the timestamp before passing to ESL parser.
> 
> 

Applied to powerpc/next.

[1/1] security/integrity: fix pointer to ESL data and its size on pseries
      https://git.kernel.org/powerpc/c/e66effaf61ffb1dc6088492ca3a0e98dcbf1c10d

cheers
