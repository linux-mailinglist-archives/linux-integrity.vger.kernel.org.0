Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B7D6773C7
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Jan 2023 02:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjAWB0J (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 22 Jan 2023 20:26:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjAWB0J (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 22 Jan 2023 20:26:09 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D00CD50C
        for <linux-integrity@vger.kernel.org>; Sun, 22 Jan 2023 17:26:05 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id d30so15963480lfv.8
        for <linux-integrity@vger.kernel.org>; Sun, 22 Jan 2023 17:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nui3aYb9CGR+In/FyCzA7k3LalPBjPUNzvFVZT3HiIE=;
        b=ObvLeOLtXRDn2aWA5iTlbBbRDVPf0mhJag6RtBCtD42rWUvfoRptXaIfGtYjRnPQjH
         RVN8P7Cgcy1O/PfTyoD5VhNdAFpddj2gnI5AXJdk5KvmRPhqQjOlq5XlMTlKWiZ4PkRc
         Fck58IX8OiZG38iIz2Nl4sRkS5c6DlBWLtSo33zhLxZAB/aRJAzcfhPTTz4X44s5USq/
         J6wo2wNMQgSSZqPs9WxLkovK6dFBwNO1bOJHIZJ39PTqLbodhC3hcNE0phDT4kz5T7LM
         2lD6Mdg9fGV6aAtLWcOQt7ck+WIPhxXryGiOykh9NuDnoXqy1GkNnReXhpMkS9w8NQkE
         5vJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nui3aYb9CGR+In/FyCzA7k3LalPBjPUNzvFVZT3HiIE=;
        b=W00Ulsjgj/Krl16jQpNEWz9tpvMD332BYaeLKRPMt8IH/Q0AM4oOtcv7pCgGBcwg/x
         4HclkyeKdVFBiJtYjMd+6w9yyjbjOKIdH7qcKhGSZdPJ7zTvJ7ryncy237OckV4WSRYE
         apjgwyUjQQsFDBCeRw7unnFOdZcj9yQy2VcCCIUrGtgfIrEPiHZGjGTGabxAMJ1X84Ag
         RbaYgU9MIYYS/LXzu65Wx3YcgHdez0p4k/7c73xx0Qx1GkEE5QKAzlySyYKW9NK7wBqr
         4vr5GytvVjA0/wh/V7LsIyOjbVMaBKF1y1d7W87ozfl6CACVsu0w/lp8OIectDjztiWH
         Dl2g==
X-Gm-Message-State: AFqh2kpvDCkmJbwGwPf7xL4Yq0lU3zRWBj7Dw9WGwjArnpcsx62tjE+f
        5d6Vhrx9okUgCk6IsLlwbOa1zw==
X-Google-Smtp-Source: AMrXdXvGlJchmSJWLhV3LTrd28JGiQHDpCHELKe7ql9hXF1rJle7RomDY7eTjk+THhof2GWno8+jNw==
X-Received: by 2002:ac2:43a5:0:b0:4b5:688e:ee10 with SMTP id t5-20020ac243a5000000b004b5688eee10mr5020704lfl.16.1674437162976;
        Sun, 22 Jan 2023 17:26:02 -0800 (PST)
Received: from google.com (38.165.88.34.bc.googleusercontent.com. [34.88.165.38])
        by smtp.gmail.com with ESMTPSA id d20-20020a056512369400b004cafe989c6dsm6406669lfs.91.2023.01.22.17.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jan 2023 17:26:02 -0800 (PST)
Date:   Mon, 23 Jan 2023 01:25:56 +0000
From:   Matt Bobrowski <mattbobrowski@google.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     dmitry.kasatkin@gmail.com, linux-integrity@vger.kernel.org
Subject: Re: [PATCH] ima: fix error handling logic when file measurement
 failed
Message-ID: <Y83iJKFK5Z6Eu04u@google.com>
References: <Y7T1eAAVXoZ70MPM@google.com>
 <Y83JvB7+IwxqRgMZ@google.com>
 <af4692dae46ec21dd2ecd29c60a8dea18bf90eef.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af4692dae46ec21dd2ecd29c60a8dea18bf90eef.camel@linux.ibm.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Jan 22, 2023 at 07:54:00PM -0500, Mimi Zohar wrote:
> Hi Matt,
> 
> On Sun, 2023-01-22 at 23:41 +0000, Matt Bobrowski wrote:
> > Hey Mimi,
> > 
> > Just a gentle ping on this one. 
> > 
> > On Wed, Jan 04, 2023 at 03:41:44AM +0000, Matt Bobrowski wrote:
> > > Restore the error handling logic so that when file measurement fails,
> > > the respective iint entry is not left with the digest data being
> > > populated with zeroes.
> > > 
> > > Fixes: 54f03916fb89 ("ima: permit fsverity's file digests in the IMA measurement list")
> > > Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
> 
> As of Friday, they're both queued in the next-integrity branch and in
> linux-next shortly.

Oh, cool. I should've checked your tree before reaching out. Thanks
for the confirmation though.

/M
