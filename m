Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED5437173B
	for <lists+linux-integrity@lfdr.de>; Mon,  3 May 2021 16:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbhECO5J (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 3 May 2021 10:57:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:60864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229607AbhECO5I (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 3 May 2021 10:57:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DAD15611BF;
        Mon,  3 May 2021 14:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620053775;
        bh=xv32LexS87J6yWzpujvH+lIncd4ijHFRlcTNbaGV6S8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f51lklWqZBw5pbDwEr6wz8WtxE2rR5HXP7D7ZC7bsOUGjrTeX6p10jCekkHWYHgbL
         1ChKTZRulAlLPhIFDBVWiEHafpB9XJZwrNsRLWdTYayR8GwpWowHtnWOmMKv1MrKYo
         HbN/0EVgfsY4Rem9bLrX0UF8sHchpbs6Ur4EfoNXl9EdOv97WF2/iQfMhZEzDXQq+h
         4rC0ixTB6dd3cUNPafN5cjuxjrHkEZQIluTOuvryCSOWA/A9PMHIRehSJ8DCGKBxVA
         Ne2GNhNWTWTpjTdSf9raPyk8FDzARidkwi9tEYvG7eN769x95btOUAljITmPp5TP6H
         cVDB+KNXA1X0g==
Date:   Mon, 3 May 2021 17:56:12 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     trix@redhat.com
Cc:     jejb@linux.ibm.com, zohar@linux.ibm.com, dhowells@redhat.com,
        jmorris@namei.org, serge@hallyn.com,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KEYS: trusted: fix memory leak
Message-ID: <YJAPDLo/FPIbdJR9@kernel.org>
References: <20210430185810.3331311-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210430185810.3331311-1-trix@redhat.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Apr 30, 2021 at 11:58:10AM -0700, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> Static analysis reports this problem
> trusted-keys/trusted_tpm1.c:496:10: warning: Potential memory leak
>   return ret;
>          ^~~
> 
> In tpm_seal() some failure handling returns directly, without
> freeing memory.
> 
> Fixes: 5df16caada3f ("KEYS: trusted: Fix incorrect handling of tpm_get_random()")
> Signed-off-by: Tom Rix <trix@redhat.com>

Hi, thanks appreciate this but unfortunately applied Colin's fix already
:-/

/Jarkko
