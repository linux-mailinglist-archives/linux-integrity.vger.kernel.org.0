Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9C6B4883DB
	for <lists+linux-integrity@lfdr.de>; Sat,  8 Jan 2022 14:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbiAHNzt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 8 Jan 2022 08:55:49 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:39266 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiAHNzs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 8 Jan 2022 08:55:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 474DD60F55;
        Sat,  8 Jan 2022 13:55:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30F25C36AE3;
        Sat,  8 Jan 2022 13:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641650147;
        bh=msNyWHXoiiEE+2BjivK23GaMaPIdW4ieSoU+FWgzt8E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IjsLciz4L5mFWFYGeWBQm5esy01sXRubcDtG7THTzN4HmIJ5Bnt+P4haZI0QFxzXy
         HWiRN9j9nuw7PCanJYU/8m7ZQbBfhuIIqHQPNYpH7bLfrb4zFJxIqd4rD0gAMkfRlM
         Y8sh+QlQZEHeUW+hNPti0XlW2eZoZU4sk1zrfCqwp+rx5/uds9/M8+nQD7jZqE9eUd
         eYxSDOnhh3Q9e+WNFJ5W7/hYprvMPdMjKwO3g1EAzaMnhwm0zpHeZ0IHi5ma5PrnOQ
         FxiC4+X3IeXrAqytnr8qhePwAx7Z+AZB408HS36A+ryml0GqwCdqMWUHi+LgPBAjFo
         JirglWMCppsCw==
Date:   Sat, 8 Jan 2022 15:55:39 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Nayna Jain <nayna@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        dhowells@redhat.com, zohar@linux.ibm.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dimitri.ledkov@canonical.com,
        seth@forshee.me, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v7 1/3] certs: export load_certificate_list() to be used
 outside certs/
Message-ID: <YdmX2/BabFk2bNAv@iki.fi>
References: <20220105175410.554444-1-nayna@linux.ibm.com>
 <20220105175410.554444-2-nayna@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105175410.554444-2-nayna@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jan 05, 2022 at 12:54:08PM -0500, Nayna Jain wrote:
> load_certificate_list() parses certificates embedded in the kernel
> image to load them onto the keyring.
> 
> Commit "2565ca7f5ec1 (certs: Move load_system_certificate_list to a common
> function)" made load_certificate_list() a common function in the certs/
> directory. Now, export load_certificate_list() outside certs/ to be used
> by load_platform_certificate_list() which is added later in the patchset.

Also, please describe the specific use it will be used. Patchset is not
a valid cross-reference in this context.

/Jarkko
