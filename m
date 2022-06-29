Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3FF955F376
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Jun 2022 04:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiF2Cp5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 28 Jun 2022 22:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiF2Cp4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 28 Jun 2022 22:45:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF081F2E7;
        Tue, 28 Jun 2022 19:45:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 37AE4B82160;
        Wed, 29 Jun 2022 02:45:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57B34C341C8;
        Wed, 29 Jun 2022 02:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656470752;
        bh=Kns1b2wvTCNOXEwTDjTr3+0AiRB2IPCO+5uch2ZB3Dc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jEvt9aKvJS/bmSx5oGNgHCX4kUOnjswY44ZmtiN9Z+GlCW6uOmq6ytarZELV3Gneu
         4Vm7a7CB/EWqv4y/n2AdWJFppTwYGu56KvcI84XBUiKM/32s0piysekaJGDcVnQWaC
         8kZ2eI7rkv3YM5BIlF5Nw24dP/cpLh0Td3MA8vTSVnSMtPd1ODyfZueoF6sTuocAEc
         J8CiU835PtwI1BBWIbhyACWMLRUDI4kAjnpUh7uRdGlLn8g1lS6LIEvugThNZfu9Ar
         yZzxjkdc1OJkcy67/g3u4iH2+YrD6VgYgnryg5KtRQcuqW2ZXOEZuLMAIVks1KaW1p
         EFFOxBLVLtcfA==
Date:   Wed, 29 Jun 2022 05:45:49 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Rob Herring <robh@kernel.org>, kexec@lists.infradead.org,
        devicetree@vger.kernel.org, linux-integrity@vger.kernel.org,
        nayna@linux.ibm.com, nasastry@in.ibm.com,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH v2 1/3] tpm: of: Move of-tree specific code from tpm
 driver into of driver
Message-ID: <Yru83e4OLW7vH5/o@kernel.org>
References: <20220616154130.2052541-1-stefanb@linux.ibm.com>
 <20220616154130.2052541-2-stefanb@linux.ibm.com>
 <20220627224325.GB3082294-robh@kernel.org>
 <170c78f7-f0ba-c186-dacf-55759dae9b83@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170c78f7-f0ba-c186-dacf-55759dae9b83@linux.ibm.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jun 28, 2022 at 09:29:48AM -0400, Stefan Berger wrote:
> 
> 
> On 6/27/22 18:43, Rob Herring wrote:
> > On Thu, Jun 16, 2022 at 11:41:28AM -0400, Stefan Berger wrote:
> > > Simplify tpm_read_log_of() by moving Openfirmware-specific code into
> > > the Openfirmware driver to make the code reusable. Call the new
> > 
> > There is no such 'Openfirmware driver'.
> > 
> > > of_tpm_get_sml_parameters() function from the TPM Openfirmware driver.
> > > 
> > > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > > Cc: Jarkko Sakkinen <jarkko@kernel.org>
> > > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > > Cc: Rob Herring <robh+dt@kernel.org>
> > > Cc: Frank Rowand <frowand.list@gmail.com>
> > > ---
> > >   drivers/char/tpm/eventlog/of.c | 31 +++++--------------------------
> > >   drivers/of/Makefile            |  2 +-
> > >   drivers/of/device_node.c       | 27 +++++++++++++++++++++++++++
> > 
> > Humm, definitely the wrong direction. Generally, code for specific
> > bindings does not go in drivers/of/. There used to be some, but we've
> > moved it to the appropriate subsystems. kexec was an exception to not
> > have 2 copies of the same code in arch/.
> 
> The function I am moving here is called by the TPM subsystem and also now by
> of/kexec.c. The latter is compiled under the following conditions:
> 
> ifdef CONFIG_KEXEC_FILE
> ifdef CONFIG_OF_FLATTREE
> obj-y	+= kexec.o
> endif
> endif
> 
> The code that current calls it is compiled under the following conditions:
> 
> tpm-$(CONFIG_OF) += eventlog/of.o
> 
> To make it available to both I could keep it in the TPM subsystem like this:
> 
> obj-$(CONFIG_OF) = tpm_of.o
> 
> 
> Jarrko, if you read this, any comment?
> 
> 
>    Stefan

Why can't you convert of_tpm_get_sml_parameters() to inline function?

BR, Jarkko
