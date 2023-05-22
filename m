Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B0670B6AA
	for <lists+linux-integrity@lfdr.de>; Mon, 22 May 2023 09:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbjEVHjz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 22 May 2023 03:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjEVHjy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 22 May 2023 03:39:54 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9EB0AC;
        Mon, 22 May 2023 00:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684741193; x=1716277193;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=7cMpYequ3bVujnTZAQ0+mCVTPIv6VCv9TnnX/b7NE50=;
  b=IuH3d+hunhfU2aMTWZQUOG+3Luc/C5OrAsHtfyXiW6erLTI+N4tB/gr7
   KHHsGdDJq/VLz57joSFXNWFFn90cs3BH/F00qKHYl+tat6uXQOFan+4cU
   WokEN0Ra6TGAtsf7lTowtbRpu7bTyy/TvU1R9/0xmfsm8NXo5r6avTF8J
   nQV6Sm62RCCTFOaDoYkzIH9KgGp/TuE6kNLHYBFzXua6QwRd6jVBWTH71
   OK8dD1/hjnTCqluy8/xAdhb1HPeZrl8L3+TaWyIZkIzDKJXUZ4x6VfaJN
   +ykwy85HhLP9n56AKCbcfi+OUvGSYrnGJCH3OBlFyR+hycub6e5vblEfA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="342304616"
X-IronPort-AV: E=Sophos;i="6.00,183,1681196400"; 
   d="scan'208";a="342304616"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 00:39:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="703408569"
X-IronPort-AV: E=Sophos;i="6.00,183,1681196400"; 
   d="scan'208";a="703408569"
Received: from bbattach-mobl.ger.corp.intel.com (HELO [10.251.220.157]) ([10.251.220.157])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 00:39:51 -0700
Message-ID: <2c94260b-ac97-3f5e-331b-76f1a17ec5b5@linux.intel.com>
Date:   Mon, 22 May 2023 10:40:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH - for 6.4] tpm: tpm_tis: Disable interrupts for AEON
 UPX-i11
Content-Language: en-US
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, l.sanfilippo@kunbus.com
References: <20230517122931.22385-1-peter.ujfalusi@linux.intel.com>
 <ohdpul6hax5bj5hhsnpt7i3ejbttivufmoolzunbhipexjkczi@meg3zx2yqkc7>
 <CSPMQ03V3G7G.EBWKDRE4B0XY@suppilovahvero>
 <432df3cf-da16-1f2a-02dc-e2c371c1f29c@linux.intel.com>
In-Reply-To: <432df3cf-da16-1f2a-02dc-e2c371c1f29c@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 18/05/2023 23:24, Péter Ujfalusi wrote:
> 
> The version is used to differentiate the revisions of the UPX-i11
> boards, and this issue present in all revisions.
> 
>> I can squash this to the commit I pushed (it is not yet mirrored
>> to linux-next), if I get the dmidecode info.
> 
> System Information
>         Manufacturer: AAEON
>         Product Name: UPX-TGL01
>         Version: V1.0
>         Serial Number: Default string
>         UUID: a300091d-fb1c-ce1c-1d30-0007328efc11
>         Wake-up Type: Power Switch
>         SKU Number: Default string
>         Family: Default string
> 
> I have used this description as it it is used for SOF, probably
> DMI_MATCH(DMI_PRODUCT_NAME, "UPX-TGL01")
> should be added?

Jarkko: I have tested that adding the
DMI_MATCH(DMI_PRODUCT_NAME, "UPX-TGL01")
works.

I would also do a small update to commit message: "120000 jiffies"  to
"120000 msec".
On my setup 120000 msec ends up to be 120000 jiffies.

How do you prefer to handle this?
I can send a v2 on top of linux-next / mainline
I can send a fixup patch which can be squashed to the patch you have in
your master branch atm
Or you add this line by yourself?

Either way is fine for me, whichever works best for you.

-- 
Péter
