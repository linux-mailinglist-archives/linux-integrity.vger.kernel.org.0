Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 406697323F1
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Jun 2023 01:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240418AbjFOXy1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 15 Jun 2023 19:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240000AbjFOXyZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 15 Jun 2023 19:54:25 -0400
Received: from cavan.codon.org.uk (irc.codon.org.uk [IPv6:2a00:1098:84:22e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8471BF9
        for <linux-integrity@vger.kernel.org>; Thu, 15 Jun 2023 16:54:23 -0700 (PDT)
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
        id 0BDEC40A72; Fri, 16 Jun 2023 00:54:22 +0100 (BST)
Date:   Fri, 16 Jun 2023 00:54:22 +0100
From:   Matthew Garrett <mjg59@srcf.ucam.org>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca
Subject: Re: Avoiding EBUSY on TPM writes
Message-ID: <20230615235422.GA15637@srcf.ucam.org>
References: <20230615210946.GA13094@srcf.ucam.org>
 <d157ccc308103b8bf158c903dfa53ee723db58fb.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d157ccc308103b8bf158c903dfa53ee723db58fb.camel@HansenPartnership.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,KHOP_HELO_FCRDNS,SPF_HELO_NEUTRAL,
        SPF_NEUTRAL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jun 15, 2023 at 07:38:57PM -0400, James Bottomley wrote:

> However, this behaviour is per-fd, why can't you just open multiple
> fd's for your multiple accesses?  /dev/tpmrm0 will assure that they
> don't see each other and that the commands are properly sequenced
> without giving you an EBUSY.  And bonus you don't have to keep global
> track of how many transient resources you've used.

Argh! Sorry, I'd missed that this was per-fd - that makes complete 
sense. Let me figure out why we're re-using the same fd for multiple 
requests.
