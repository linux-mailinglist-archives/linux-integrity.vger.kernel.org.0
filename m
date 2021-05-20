Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32F5F38B3DD
	for <lists+linux-integrity@lfdr.de>; Thu, 20 May 2021 17:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233241AbhETQBO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 20 May 2021 12:01:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:55222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233193AbhETQBN (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 20 May 2021 12:01:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 74430610A8;
        Thu, 20 May 2021 15:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621526392;
        bh=J7btpZi7y4UrNwPzAa1BVbYzDrZodtP7CYkne7Yl2sc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fQ3xJQulbZOJceu/CiUOV/PKvZizFJd+4pjhZXdQ8SrEV5QBUbg93eKR/6iZGSGlB
         7U4va4HE78FbtLPpquvufFwsEEGpjUlN6ATCEomn66C2qR0BINn4xtlgQXFZWlhquV
         4BgSBDmmxfd0uFb4l4tv2jNHYouArLkAI8IoNVJarn81kyDkpBOS5ub53C6oIFG+k/
         9997NrXEQGn2Y88I4RSx3Arv+vZMkJTgsZFSRvfRLUvQ75aIYYiEfIdFzeaTvLLrgK
         dybmGZ+XhtWA3LVJKzRal5i2E7O1Usu/yeoKa9/GjILrleKzpNrFwr9WA7QFv7XiOy
         IrsVsOy13O9ww==
Date:   Thu, 20 May 2021 18:59:49 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Eric Snowberg <eric.snowberg@oracle.com>
Cc:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        dhowells@redhat.com, dwmw2@infradead.org,
        dmitry.kasatkin@gmail.com, jmorris@namei.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, zohar@linux.ibm.com,
        torvalds@linux-foundation.org, serge@hallyn.com,
        James.Bottomley@hansenpartnership.com, pjones@redhat.com,
        glin@suse.com
Subject: Re: [RFC PATCH 1/3] keys: Add ability to trust the platform keyring
Message-ID: <YKaHdWkXfk4DwqwR@kernel.org>
References: <20210517225714.498032-1-eric.snowberg@oracle.com>
 <20210517225714.498032-2-eric.snowberg@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517225714.498032-2-eric.snowberg@oracle.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, May 17, 2021 at 06:57:12PM -0400, Eric Snowberg wrote:
> Add the ability to allow the secondary_trusted keyring to trust
> keys in the platform keyring. This is done by doing a key_link

What this looks for me doing is to *replace* the secondary 
trusted keyring with the platform keyring.

So this should be "Add ability to replace the secondary trusted
keyring with the platform keyring." This is what the code change
is actually doing so it would be nice to say it out loud.

> of the platform_trusted_keys to the secondary_trusted_keys.
> After they are linked, the platform_trusted_keys can be used for
> validation instead of the secondary_trusted_keys if the user
> chooses. This functionality will be used in a follow on patch.
> 
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>

/Jarkko 
