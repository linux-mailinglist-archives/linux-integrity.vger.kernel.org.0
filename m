Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83AE53CCBD
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Jun 2022 17:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237751AbiFCPzn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 3 Jun 2022 11:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbiFCPzn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 Jun 2022 11:55:43 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75403BE04;
        Fri,  3 Jun 2022 08:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654271742; x=1685807742;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=blHQrZ0g94mMvLynPtoK8ncChfAm2Hug5DTS5ZrddFY=;
  b=CtJI9fgQDZorAHra/fjotVhBPOpocWYo7ZaQ3gYhAB4xVed+EOUqzAbq
   DRIIgqAQl/r2HHB6ckyeEn+WEe9jCyNi4dsHmpTW+nuJhCKMV8dHlF2ZH
   YE4Xc9P5ojNqt/IC7xyqmpaNscSmAWATRotnJnE71BnQ7/YUzP4Vcg3uI
   1Saejw4A/8RxDKosn2QE7nNDWxV6wx6zzLpKnwVnF/V4Vw05OReNy5oUY
   lwNkWyL0P03a4fJuaP2JQxvvfAuG8bfepfuqkX97FPp+gp6h9qAo8Z17J
   pHtxnIDpygi6gO7YrnllDX7V47gmjxDg4VuA7bkvoQ2e/lpq10NrVKS1V
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10367"; a="362649491"
X-IronPort-AV: E=Sophos;i="5.91,274,1647327600"; 
   d="scan'208";a="362649491"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2022 08:55:42 -0700
X-IronPort-AV: E=Sophos;i="5.91,274,1647327600"; 
   d="scan'208";a="613323243"
Received: from fbarati-mobl.amr.corp.intel.com (HELO [10.251.24.19]) ([10.251.24.19])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2022 08:55:41 -0700
Message-ID: <e7758ed1-5dcb-80dd-092a-a6bb21c3997d@intel.com>
Date:   Fri, 3 Jun 2022 08:55:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4] x86/kexec: Carry forward IMA measurement log on kexec
Content-Language: en-US
To:     Jonathan McDowell <noodles@fb.com>, Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org
References: <YmKyvlF3my1yWTvK@noodles-fedora-PC23Y6EG>
 <YmgjXZphkmDKgaOA@noodles-fedora-PC23Y6EG>
 <YnuJCH75GrhVm0Tp@noodles-fedora.dhcp.thefacebook.com>
 <Yn01Cfb3Divf49g7@noodles-fedora.dhcp.thefacebook.com>
 <8634d4dd0813b9522f039ed211023c2c65c6f888.camel@linux.ibm.com>
 <YpSC4AQInLM73wex@noodles-fedora.dhcp.thefacebook.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <YpSC4AQInLM73wex@noodles-fedora.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 5/30/22 01:40, Jonathan McDowell wrote:
> Borislav,
> 
> I don't think there are any outstanding review comments for me to deal
> with on this, so is it safe to assume it'll get picked up at some point
> once the merge window calms down?

Nothing here looks too crazy, but it's still been _very_ lightly
reviewed.  It doesn't seem like anyone from the kexec world has seen it,
for instance.

Mimi's review was a great start, but it would be really nice to make
sure that the kexec bits look good.
