Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21746618C0D
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Nov 2022 23:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbiKCWvO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Nov 2022 18:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbiKCWux (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Nov 2022 18:50:53 -0400
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 22F7F1AD
        for <linux-integrity@vger.kernel.org>; Thu,  3 Nov 2022 15:50:50 -0700 (PDT)
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 482A372C983;
        Fri,  4 Nov 2022 01:50:49 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 27D044A472A;
        Fri,  4 Nov 2022 01:50:49 +0300 (MSK)
Date:   Fri, 4 Nov 2022 01:50:49 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Petr Vorel <pvorel@suse.cz>, Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH ima-evm-utils v4 01/17] Revert "Reset 'errno' after
 failure to open or access a file"
Message-ID: <20221103225049.6u7xxgn3tk66n3ez@altlinux.org>
References: <20221101201803.372652-1-zohar@linux.ibm.com>
 <20221101201803.372652-2-zohar@linux.ibm.com>
 <0a70ffe5-a35a-f8fa-dfa8-be3bf2e5e29f@linux.ibm.com>
 <145f4c70ec894c4980d9455485cdac4673e01d04.camel@linux.ibm.com>
 <52e19952-a1c3-722e-2267-a625e16c37a2@linux.ibm.com>
 <4db89eab7d21124aa7945ccf4fd150c3ee4d259c.camel@linux.ibm.com>
 <Y2PREKTdNQhwhPEK@pevik>
 <6641d0eec7dd91d0d8b2f5dbf1844173a79b13fe.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <6641d0eec7dd91d0d8b2f5dbf1844173a79b13fe.camel@linux.ibm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Nov 03, 2022 at 05:35:40PM -0400, Mimi Zohar wrote:
> Hi Petr,
> 
> > > > Is the github repo now the main repo and sourceforge repo is dead?
> > 
> > > The "next" branch in both repo's are the same.  Before posting patches,
> > > I verify that github Actions works.   As a result, the next-testing
> > > branch on github is rebased frequently.  Once a patch set is ready, the
> > > "next" branch in both repo's is updated.
> > 
> > > To answer your question the github repo is primary.
> > Maybe deleting everything in sourceforge and ad put single file with link to
> > github.com would save you work (having master, next and next-testing branches
> > with this file).
> 
> Thanks, definitely appreciate time saving tips!  Vitaly suggested
> saving the sourceforge wiki info in ima-evm-utils and updating the
> file(s) like any other file.  Before removing "everything"h from
> sourceforge, that still needs to be done.

I thought markdown should be downloaded from Edit interface, which is not
available on SF for non-admins. But I found recently how to download it
in Json format via Allura API:

  curl -s https://sourceforge.net/rest/p/linux-ima/wiki/Home  | jq -r .text

Then only end-of-lines need to be fixed.

Thanks,

> 
> -- 
> thanks,
> 
> Mimi
