Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031A167638C
	for <lists+linux-integrity@lfdr.de>; Sat, 21 Jan 2023 04:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjAUD6l (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 20 Jan 2023 22:58:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjAUD6k (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 Jan 2023 22:58:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD127687;
        Fri, 20 Jan 2023 19:58:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8F89FB8100E;
        Sat, 21 Jan 2023 03:58:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4A63C433EF;
        Sat, 21 Jan 2023 03:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674273516;
        bh=wg5jTsUCu0bY1Y9UuVLkIRRHJB5eL/aLUkOVq0pCRZI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fm6Vkk32VR4dLTTwIxgiqPnn5kna97SsHFgPlFj6PYcTnhtiPGz20NA+HhdjdZ7jC
         wqVExPC1ugvRJJlg8S/h3rHcEmpOKFLKVb2iMAA88ge3U2diPZ54inRvzVEnDdQsJU
         hldripdqbwqxjoONEa3HL3F8x4O5LioMA5odidZE6eakx40FN76xgTd+HvEVc93ctG
         zQeOPRcNBcqljW3N4peR1rXvT0jbXn/YeAcO/PLo7UM1lTbPTBPyIvpEUuEdR5CL4q
         fcjpT69g1BOhZ1ntaxfeNHY4K5VoUpTE4ydtq+4V+S1hNLnEL5XP41gsprPWxjuA70
         ZIYYa0z02Ci8w==
Date:   Sat, 21 Jan 2023 03:58:33 +0000
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Eddie James <eajames@linux.ibm.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jgg@ziepe.ca, peterhuewe@gmx.de
Subject: Re: [PATCH v2 2/2] tpm: Add reserved memory event log
Message-ID: <Y8ti6RVfLAf2+tau@kernel.org>
References: <20230113161017.1079299-1-eajames@linux.ibm.com>
 <20230113161017.1079299-3-eajames@linux.ibm.com>
 <d30d23f2-46d0-acfc-4356-49e82b027a9b@linux.ibm.com>
 <3161efa3-2e72-bcc4-95d9-736a55f6535e@linux.ibm.com>
 <adced60c-3abe-8f14-9146-e15cee98d5ee@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adced60c-3abe-8f14-9146-e15cee98d5ee@linux.ibm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jan 18, 2023 at 10:01:16AM -0500, Stefan Berger wrote:
> 
> 
> On 1/18/23 09:49, Eddie James wrote:
> > 
> > On 1/18/23 07:27, Stefan Berger wrote:
> > > 
> > > 
> > > On 1/13/23 11:10, Eddie James wrote:
> > > > Some platforms may desire to pass the event log up to linux in the
> > > 
> > > Which platforms are these that work like this?
> > 
> > 
> > Platforms booting from U-Boot without EFI. So at the moment, IBM's OpenBMC systems hope to use this.
> 
> It may be worth to mention this in the patch description in case someone wonders which
> systems would take that path.

+1

BR, Jarkko
