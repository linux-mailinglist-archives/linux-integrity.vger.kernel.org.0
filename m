Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE2A708800
	for <lists+linux-integrity@lfdr.de>; Thu, 18 May 2023 20:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjERSuy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 18 May 2023 14:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjERSux (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 May 2023 14:50:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB452E5D
        for <linux-integrity@vger.kernel.org>; Thu, 18 May 2023 11:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684435808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jhNH5X6r0ZKpS+GpJhPbsRYtE9hrwN2qv/IBByfk+DM=;
        b=ePf0ja5AEV0uxsf07ckCsPF2udMuaPvSSb+Ync6CKGTnKD0l1YxICITtt64YLDeEB7njqR
        r+iyhNfE+aQMhQ1269sBbN2nyHtc/byRMtdUovWEKBf7tHWB2llU1eBIAMslMh9tFNrp1i
        MFjDOWJXrlveKkg+dX7lGz0ZECfJBVg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-9rdhFBHQMhq6eb_YQXgTsA-1; Thu, 18 May 2023 14:50:04 -0400
X-MC-Unique: 9rdhFBHQMhq6eb_YQXgTsA-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-61b1dbdb2f9so33518316d6.3
        for <linux-integrity@vger.kernel.org>; Thu, 18 May 2023 11:50:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684435804; x=1687027804;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jhNH5X6r0ZKpS+GpJhPbsRYtE9hrwN2qv/IBByfk+DM=;
        b=h4SKtPnEreg+hFJS0AjNac7IoXXRdIDvqa+JV+tbhFTQVhuKVzpXVFCY2ISspUx1nn
         tTIQqsi3x9WcDT/iYhqbMPCsff7g5PR23Libywj0QG1x0oIYrU1qWtXQRVJ4xR7vHtRQ
         +qyAmRnTrzv74Epr+VhwRgW1hrswS2oCAH+lJpa2TSlkId5uUIDdDUOOHEXTatw+VC1X
         fPVfWrMl7edJsp/JrkrjxUhceHGiWy4c0HOUk2VvVpjJpU3naIUYy/uzFZrdHiryIuYk
         Iw7oGvN8bSkFDFy6Z7lQvRswT916RJ/68U39ZAmJzjzuTf9L9W9AUHySZvWxxcUREkl8
         aP0A==
X-Gm-Message-State: AC+VfDwfvyB2ofmCtVnRCnVuNYAnkTVnk8UO831I5uKT5uYGUrLuI8R4
        W0PVawx4xavUqx/xyEAozPqOex3sHwdiUCCkizdEBzb/v0C4UfNf5pL2IykxmF6np2pb8L7lUJg
        Ykdmvq4dNYKYLnBdkhRJTNzm+8jEopqzSLTq+
X-Received: by 2002:a05:6214:2a8b:b0:5c1:fa35:fe6 with SMTP id jr11-20020a0562142a8b00b005c1fa350fe6mr44426qvb.24.1684435803859;
        Thu, 18 May 2023 11:50:03 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5kRFTSioRtw0V5WoyySUFzvYh5S7whyTa69eUEgil2/6d/1Yxp3N2ckI4ryuPgJJXkfx7PLw==
X-Received: by 2002:a05:6214:2a8b:b0:5c1:fa35:fe6 with SMTP id jr11-20020a0562142a8b00b005c1fa350fe6mr44404qvb.24.1684435803593;
        Thu, 18 May 2023 11:50:03 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id h11-20020a0cedab000000b0061ac0b43a16sm703530qvr.103.2023.05.18.11.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 11:50:03 -0700 (PDT)
Date:   Thu, 18 May 2023 11:50:01 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        l.sanfilippo@kunbus.com
Subject: Re: [PATCH - for 6.4] tpm: tpm_tis: Disable interrupts for AEON
 UPX-i11
Message-ID: <ohdpul6hax5bj5hhsnpt7i3ejbttivufmoolzunbhipexjkczi@meg3zx2yqkc7>
References: <20230517122931.22385-1-peter.ujfalusi@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517122931.22385-1-peter.ujfalusi@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, May 17, 2023 at 03:29:31PM +0300, Peter Ujfalusi wrote:
> The interrupts initially works on the device but they will stop arriving
> after about 200 interrupts.
> 
> On system reboot/shutdown this will cause a long wait (120000 jiffies).
> 
> The interrupts on this device got enabled by commit
> e644b2f498d2 ("tpm, tpm_tis: Enable interrupt test")
> 
> Prior to this point the interrupts were not enabled on this machine.
> 
> Complements: e644b2f498d2 ("tpm, tpm_tis: Enable interrupt test")
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
> ---
> Hi,
> 
> This patch applies on top of mainline since 6.4-rc1 takes about 2 minutes to
> reboot on this machine, linux-next have
> e7d3e5c4b1dd tpm/tpm_tis: Disable interrupts for more Lenovo devices
> 
> I'm not sure if I shouold send this on top of next or mainline is fine, please
> let me know the preferred way to get this to 6.4.
> 
> Regards,
> Peter
> 
>  drivers/char/tpm/tpm_tis.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
> index 7af389806643..aad682c2ab21 100644
> --- a/drivers/char/tpm/tpm_tis.c
> +++ b/drivers/char/tpm/tpm_tis.c
> @@ -122,6 +122,13 @@ static const struct dmi_system_id tpm_tis_dmi_table[] = {
>  			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T490s"),
>  		},
>  	},
> +	{
> +		.callback = tpm_tis_disable_irq,
> +		.ident = "UPX-TGL",

Is this the product version returned by dmidecode? If yes,
then the entry could be made more specific by adding a
DMI_MATCH(DMI_PRODUCT_VERSION, "UPX-TGL"), and only disable
for this device instead of any system that matches the vendor
AAEON.

> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "AAEON"),
> +		},
> +	},
>  	{}
>  };
>  
> -- 
> 2.40.1
> 

