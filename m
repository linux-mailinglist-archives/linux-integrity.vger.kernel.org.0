Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2E655CD07
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Jun 2022 15:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240008AbiF0XJu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 27 Jun 2022 19:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237641AbiF0XJt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 27 Jun 2022 19:09:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E459F167C3;
        Mon, 27 Jun 2022 16:09:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 256BE61553;
        Mon, 27 Jun 2022 23:09:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32C87C34115;
        Mon, 27 Jun 2022 23:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656371387;
        bh=lVxtZm/634oR9E7yrwfVlfrL+tRbWuHpVIgCUdapOC0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ImUCJO8QqovLCmKM5Oac0qiExEpJmnHHAB5wH3SlaHB+uf18B5WcQnF/S9Q7fxsIz
         PLm9BpKBEecjd6flgmk6NaIth+HZ87vVlfpriY0pblMKcQV5v6DhvqiPf109LaJZgW
         5UmVJFBKUI96fLj6jvB+mKjCRf9o8xeLTytvuonhwMlGDeBzs18lp+ZlLSIEBuwZ0l
         KWYYTSnZKQWL785U2Wl8Lz+x0lXizEl+9KwhUVmyynCuWgzVzFrBxEjm+Dn0NGleBl
         sloj/NMe5NhDY666hQxUFJpvhqxk7jq/TWK0qb6uK6ncOIT9aIA9+OcA9qwilNydck
         RWrH6Z9C5zOuQ==
Date:   Tue, 28 Jun 2022 02:09:42 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux@mniewoehner.de, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, l.sanfilippo@kunbus.com,
        lukas@wunner.de, p.rosenberger@kunbus.com
Subject: Re: [PATCH v6 5/9] tpm, tpm_tis: Only handle supported interrupts
Message-ID: <Yro4tl7g1IqkEszT@kernel.org>
References: <20220621132447.16281-1-LinoSanfilippo@gmx.de>
 <20220621132447.16281-6-LinoSanfilippo@gmx.de>
 <Yrf/azvJlzWfOE9y@kernel.org>
 <6b950660-6a78-f329-39b4-11d585e4959c@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b950660-6a78-f329-39b4-11d585e4959c@gmx.de>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Jun 26, 2022 at 02:18:17PM +0200, Lino Sanfilippo wrote:
> On 26.06.22 at 08:40, Jarkko Sakkinen wrote:
> >
> > I would instead mask out bits and write a helper function
> > taking care of this:
> >
> > static u8 tpm_tis_filter_sts_mask(u8 int_mask, u8 sts_mask)
> > {
> >         struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
> >
> >         if (!(int_mask & TPM_INTF_STS_VALID_INT))
> >                 sts_mask &= ~TPM_STS_VALID;
> >
> >         if (!(int_mask & TPM_INTF_DATA_AVAIL_INT))
> >                 sts_mask &= ~TPM_STS_DATA_AVAIL;
> >
> >         if (!(int_mask & TPM_INTF_CMD_READY_INT))
> > 		sts_mask &= ~TPM_STS_COMMAND_READY;
> >
> >         return sts_mask;
> > }
> >
> > Less operations and imho somewhat cleaner structure.
> >
> > Add suggested-by if you want.
> 
> I thought of a helper like this before but then decided to
> not introduce another function to keep the code changes minimal. But yes,
> it is indeed cleaner. I will do the change and resubmit the series.
> 
> Thanks for the review!
> 
> Regards,
> Lino

Yeah, please don't add suggested-by, it's such a minor detail
in the overall patch :-) Thanks for taking time to fix these
glitches and also taking all the feedback into account (and
also being patient).
 
BR, Jarkko
