Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62480BC682
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Sep 2019 13:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504630AbfIXLSj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 24 Sep 2019 07:18:39 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:35590 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2504627AbfIXLSi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 24 Sep 2019 07:18:38 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 6D7878EE175;
        Tue, 24 Sep 2019 04:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1569323918;
        bh=2f54yALR7qGp4YgS4aDBSShfe/qfzBqvEZHy6t6kIlI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=pmrxJcTU1yQtJ/czlBI0uNZUA1ZiJoaKGrYxCSKN9wZELATN4MB7kBctN3usLfLes
         rdbXGSSh4CeTt5OPTzsz0oUdINhj8PwRKDr9MUWc1O1LxdLv3widGjaEq0mKtSa3f5
         ta310Rw0R5aqpn0iWw9nzh+wqQAznQ+0j3ZhC1nQ=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Sc2zoGPzz6oH; Tue, 24 Sep 2019 04:18:38 -0700 (PDT)
Received: from [192.168.101.242] (unknown [24.246.103.29])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id B44768EE12C;
        Tue, 24 Sep 2019 04:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1569323918;
        bh=2f54yALR7qGp4YgS4aDBSShfe/qfzBqvEZHy6t6kIlI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=pmrxJcTU1yQtJ/czlBI0uNZUA1ZiJoaKGrYxCSKN9wZELATN4MB7kBctN3usLfLes
         rdbXGSSh4CeTt5OPTzsz0oUdINhj8PwRKDr9MUWc1O1LxdLv3widGjaEq0mKtSa3f5
         ta310Rw0R5aqpn0iWw9nzh+wqQAznQ+0j3ZhC1nQ=
Message-ID: <1569323907.24519.9.camel@HansenPartnership.com>
Subject: Re: [PATCH v6 05/12] tpm2-sessions: Add full HMAC and
 encrypt/decrypt session handling
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date:   Tue, 24 Sep 2019 07:18:27 -0400
In-Reply-To: <20190920143523.GE9578@linux.intel.com>
References: <1568031408.6613.29.camel@HansenPartnership.com>
         <1568031657.6613.34.camel@HansenPartnership.com>
         <20190920143337.GD9578@linux.intel.com>
         <20190920143523.GE9578@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2019-09-20 at 17:35 +0300, Jarkko Sakkinen wrote:
> On Fri, Sep 20, 2019 at 05:34:00PM +0300, Jarkko Sakkinen wrote:
> > On Mon, Sep 09, 2019 at 01:20:57PM +0100, James Bottomley wrote:
> 
> Forgot to ask: what is the new field handles?

You mean for the null seed or for the virtual handles?

For the former, there isn't one since the null seed is maintained as a
context when not in use, although since the null seed context is loaded
before an operation it will mostly get 80000000 for the brief time it
is used.  For the latter, there's no change in the way virtual handles
are processed.

James

