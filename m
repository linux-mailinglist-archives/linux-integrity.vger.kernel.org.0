Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC127A6FE
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Jul 2019 13:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730238AbfG3Lbj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 30 Jul 2019 07:31:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:60868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728412AbfG3Lbj (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 30 Jul 2019 07:31:39 -0400
Received: from localhost.localdomain (ool-18bba523.dyn.optonline.net [24.187.165.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA45B2087F;
        Tue, 30 Jul 2019 11:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564486299;
        bh=QWVn3Dcg6llAO1kr6AD3HoOEKYwjUu4hHECH/IB2vPE=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=IwFfwYY+ezX1lgSGnO7mJQWXAy5F0ii8t/8fnMLxleCurpzyaRPEIBM7tYDPOCvu9
         YbJQ7hvetsVj5m851dVJhfZ3fxfKCdfX/8LoCY12yUgoQ0AcnJDi48XJX3yHDx3JWE
         eLOSCPQ/ZLa/3V4S17iZbqogtQOKGaREZ7shtDQM=
Message-ID: <1564486268.4189.30.camel@kernel.org>
Subject: Re: [PATCH] ima-evm-utils: fix trailing chars from configure script
From:   Mimi Zohar <zohar@kernel.org>
To:     "Bruno E. O. Meneguele" <bmeneg@redhat.com>,
        linux-integrity@vger.kernel.org, dmitry.kasatkin@gmail.com
Date:   Tue, 30 Jul 2019 07:31:08 -0400
In-Reply-To: <20190727125501.30914-1-bmeneg@redhat.com>
References: <20190727125501.30914-1-bmeneg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, 2019-07-27 at 09:55 -0300, Bruno E. O. Meneguele wrote:
> Two chars were left in a AC_DEFINE() in configure.ac, leading to an error
> message during ./configure call:
> 
> checking for tsspcrread... yes
> ./configure: line 9894: ],: command not found
> 
> Signed-off-by: Bruno E. O. Meneguele <bmeneg@redhat.com>

Thanks!

Mimi
