Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B205F693F2F
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Feb 2023 08:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjBMHzT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 13 Feb 2023 02:55:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjBMHzP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 Feb 2023 02:55:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB498126CC;
        Sun, 12 Feb 2023 23:54:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 764FB6091F;
        Mon, 13 Feb 2023 07:54:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 887CAC433D2;
        Mon, 13 Feb 2023 07:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676274897;
        bh=DqzDuNoxyaD1ldPm3X/0qqam3Ewe4anz3SG/CvWps/0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dSpumf4qd22kq7DKkT0xsWGl8dAnbzWGS+fxJ73M1Hl/a0LIL65Zbwfe/ba5Mt/a/
         TvWzd0SzTyHL99D7qW46cJJh28zDP9fZNNubkeZdDj+5TbxOnta+KOQv1k6aKKRlzC
         /E4cW/i+DvnvAE616OXW9wZ9Da6Cdq+uuTL+ZE9BpEueQcdbsAEuGX07oc+jLoNuvr
         IIFelrG2Ky3q1eKCBge8eTo6pE7oB7QE5TrrX8FKpbHEcAjRs5B2juikoRjfHQaePC
         hkYAzoyodgrxv9UEoRTYGBvT85Odz8oBxT5cGMfuuV+2DHyR15ljw3MCcRXr24cJBQ
         zZJ6FetTtsjEw==
Date:   Mon, 13 Feb 2023 09:54:54 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Eric Snowberg <eric.snowberg@oracle.com>, dhowells@redhat.com,
        dwmw2@infradead.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        pvorel@suse.cz, tadeusz.struk@intel.com, kanth.ghatraju@oracle.com,
        konrad.wilk@oracle.com, erpalmer@linux.vnet.ibm.com,
        coxu@redhat.com, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v4 6/6] integrity: machine keyring CA configuration
Message-ID: <Y+nszt7I9rGem1az@kernel.org>
References: <20230207025958.974056-1-eric.snowberg@oracle.com>
 <20230207025958.974056-7-eric.snowberg@oracle.com>
 <4bda209dfc891ac9044ce847785c383e89f14f97.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4bda209dfc891ac9044ce847785c383e89f14f97.camel@linux.ibm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Feb 10, 2023 at 08:05:22AM -0500, Mimi Zohar wrote:
> Hi Eric,
> 
> On Mon, 2023-02-06 at 21:59 -0500, Eric Snowberg wrote:
> > Add a machine keyring CA restriction menu option to control the type of
> > keys that may be added to it. The options include none, min and max
> > restrictions.
> > 
> > When no restrictions are selected, all Machine Owner Keys (MOK) are added
> > to the machine keyring.  When CONFIG_INTEGRITY_CA_MACHINE_KEYRING_MIN is
> > selected, the CA bit must be true.  Also the key usage must contain
> > keyCertSign, any other usage field may be set as well.
> > 
> > When CONFIG_INTEGRITY_CA_MACHINE_KEYRING_MAX is selected, the CA bit must
> > be true. Also the key usage must contain keyCertSign and the
> > digitialSignature usage may not be set.
> > 
> > Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> 
> Missing from the patch description is the motivation for this change.  
> The choices none, min, max implies a progression, which is good, and
> the technical differences between the choices, but not the reason.
> 
> The motivation, at least from my perspective, is separation of
> certificate signing from code signing keys, where "none" is no
> separation and "max" being total separation of keys based on usage.
> 
> Subsequent work, as discussed in the cover letter thread, will limit
> certificates being loaded onto the IMA keyring to code signing keys
> used for signature verification.


It would be more robust just to have two binary options for CA bit and
keyCertSign. You can use "select" for setting keyCertSign, when CA bit
option is selected.

BR, Jarkko
