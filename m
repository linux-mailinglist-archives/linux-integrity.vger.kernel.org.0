Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDC804E1DD6
	for <lists+linux-integrity@lfdr.de>; Sun, 20 Mar 2022 22:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343668AbiCTVKc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 20 Mar 2022 17:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233463AbiCTVKb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 20 Mar 2022 17:10:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063DB3EF15;
        Sun, 20 Mar 2022 14:09:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 98643B80EED;
        Sun, 20 Mar 2022 21:09:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C868C340E9;
        Sun, 20 Mar 2022 21:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647810545;
        bh=XyeGPawj4pSFo66sD7y74tNiedJnvbmAaQlFgBKJgnc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sL9K3LHIlBU+oB4kwxGG+Bs3TZtNlwntgtDJ3+/W1J3kOxToW9eyprwnTho40361B
         Y9m8UUySoD3s5ycgcOMDvjmaMZayLNmx2vVpZqvz4UQR3dcxnAe8kR3fTrTqCr7QKu
         xWIlnNzWTSsvdURB/b2y+1HDsc40HMWlO0cOD2KpJCBdjpwnoD5p5fAwA6iv8nusIE
         xoMjcNEaMqLX5LXQ6eLs+jpQDyEzp6SH7mIA7qcRBeso3hvWQe51/03YZozq7uKmKR
         S+M1xKeNWzdb5kBFXtECYiqBGiaIQ8R2KR+8KEZOQk72JGEm7ZdaFgCQk9oqogja2V
         YCLySbpovbMJg==
Date:   Sun, 20 Mar 2022 23:10:05 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Nayna Jain <nayna@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        dhowells@redhat.com, zohar@linux.ibm.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dimitri.ledkov@canonical.com,
        seth@forshee.me, rnsastry@linux.ibm.com, masahiroy@kernel.org
Subject: Re: [PATCH v12 1/4] certs: export load_certificate_list() to be used
 outside certs/
Message-ID: <YjeYLQgTul3HUtwZ@iki.fi>
References: <20220311210344.102396-1-nayna@linux.ibm.com>
 <20220311210344.102396-2-nayna@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220311210344.102396-2-nayna@linux.ibm.com>
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Mar 11, 2022 at 04:03:41PM -0500, Nayna Jain wrote:
> load_certificate_list() parses certificates embedded in the kernel
> image to load them onto the keyring.
> 
> Commit "2565ca7f5ec1 (certs: Move load_system_certificate_list to a common
> function)" made load_certificate_list() a common function in the certs/
> directory. Export load_certificate_list() outside certs/ to be used by
> load_platform_certificate_list() for loading compiled in platform keys
> onto the .platform keyring at boot time.
> 
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>

Why all tested-by tags are still missing?

BR, Jarkko
