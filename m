Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF17D97AC
	for <lists+linux-integrity@lfdr.de>; Wed, 16 Oct 2019 18:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390505AbfJPQly (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 16 Oct 2019 12:41:54 -0400
Received: from linux.microsoft.com ([13.77.154.182]:55366 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390452AbfJPQly (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 16 Oct 2019 12:41:54 -0400
Received: by linux.microsoft.com (Postfix, from userid 1001)
        id 62CFA20B71C6; Wed, 16 Oct 2019 09:41:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 62CFA20B71C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
        s=default; t=1571244113;
        bh=20BuFjNGPZIARIL2LygFu71Y2bFwJgHRMqck0VvS4DU=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=Wpce+/B7TBRxhXwrIZFtBudLAl3xrjbz8l6FNe0qDZeLBfOquzgSX8XiiYIywQOcx
         Z/uZ/TOiFG7huuA2/niFbXez/PWoMY4u1kkp0Uxc/ypAd4U8QW7JNnDI3RYPqSCb3x
         y/nKpAmvMe0zwTHICyTMrWoLOU8Ik9SyF1iyPnig=
Received: from localhost (localhost [127.0.0.1])
        by linux.microsoft.com (Postfix) with ESMTP id 4C36B30701DD;
        Wed, 16 Oct 2019 09:41:53 -0700 (PDT)
Date:   Wed, 16 Oct 2019 09:41:53 -0700 (PDT)
From:   James Morris <jamorris@linuxonhyperv.com>
X-X-Sender: jamorris@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
cc:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        sashal@kernel.org, jamorris@linux.microsoft.com,
        kgoldman@us.ibm.com, mjg59@google.com, dhowells@redhat.com,
        balajib@linux.microsoft.com, prsriva@linux.microsoft.com,
        jorhand@linux.microsoft.com, patatash@linux.microsoft.com
Subject: Re: [PATCH v0 1/1] KEYS: LSM Hook for key_create_or_update
In-Reply-To: <20191015231750.25992-2-nramas@linux.microsoft.com>
Message-ID: <alpine.LRH.2.21.1910160933590.57904@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.inter>
References: <20191015231750.25992-1-nramas@linux.microsoft.com> <20191015231750.25992-2-nramas@linux.microsoft.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 15 Oct 2019, Lakshmi Ramasubramanian wrote:

> +inline bool is_secondary_trusted_keyring(struct key *keyring)
> +{
> +	#ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
> +	return (keyring == secondary_trusted_keys);
> +	#else
> +	return false;
> +	#endif
> +}
> +
> +inline bool is_platform_trusted_keyring(struct key *keyring)
> +{
> +	#ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
> +	return (keyring == platform_trusted_keys);
> +	#else
> +	return false;
> +	#endif
> +}

See "Conditional Compilation" in Documentation/process/coding-style.rst

i.e. compile out at the function level, in the header file for these, do 
not indent the directives, add a matching comment for the #endif.


-- 
James Morris
<jamorris@linuxonhyperv.com>
