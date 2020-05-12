Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 804FB1CFEFD
	for <lists+linux-integrity@lfdr.de>; Tue, 12 May 2020 22:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730210AbgELUIZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 12 May 2020 16:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgELUIZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 May 2020 16:08:25 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2FAC061A0C
        for <linux-integrity@vger.kernel.org>; Tue, 12 May 2020 13:08:24 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id e18so2678642iog.9
        for <linux-integrity@vger.kernel.org>; Tue, 12 May 2020 13:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iQ1FXZEo9sAqjvXhulqp1o6Tr1qWg73VyBJS6q3oQSY=;
        b=ecXKDWAvXHXgK5DVRc/9P3enNHhO8C04BA3CHfw832WJhzTW/8Jvz8pSm5v6kGOwRh
         UxViVF4GBzwkr3OEqVP1+jwEU0HezbZzzXDr5SU64CyDZuDt7C/3eddKQl467oT7SmI/
         jmM6cwOkfByiCZwY86b7IJ3OrwgFjG/zvmAxkv3z5964GQ4iyAgZc50qxl2cFxgwgnaL
         6UbuX+0K56gD7rVwSxQLP6D5yFSYCH9v9XcZpXYGwAy1nFSRtxsLxEKpS5XZ+K/zmee6
         GJw8Ddd9NHnc8ZoedlfOTIFEOx1bjj68zSOg3ANjoVdI2BfchZ368LlLAnSe2DL4M1RU
         tXdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iQ1FXZEo9sAqjvXhulqp1o6Tr1qWg73VyBJS6q3oQSY=;
        b=gISTWS5EEtuKylZvNE6t/AXo2t39kaiAD0Wz96aqwJvp4o3zMB33dQZuTWjwbPVeiY
         sQeYr8Q8lQgE698oVd3Km9erMvcZ0xpwBbeOUWYv8dFshR6H845iDPFf14pVhmNGffz5
         SpKMYyV8biDhXzmRaOnSJXb+d6QXYKpnpP/FvcBUpCBHdxswtWkR/lryVExa52IzIDFr
         JmHJha/G1eQYxxO168aVbw5FVPCkgvzIe9cfkIYBFAd6XHFmQ8pEqlhAFbF9VLX64Edq
         eoirZyT10ZqfDmY1FfNiTAvn8UVhA9p/GqHedSplH6ZTYQR6ZLtCDI6w+celWYh+7d5z
         MIAA==
X-Gm-Message-State: AGi0Puarjfmzxz/Iq2EBUskDZe1ZQQBeIgxmy3jdDMPoU223wPFajrgc
        22Kxc7qijNHVqCldP30388FEVmR0SFGhiWtm/PVjQpIt
X-Google-Smtp-Source: APiQypL4wFQfR0vZuCymK1dKdrMRavz8+o57sMdnaXLgL7YcBWqhLJJKPwFM8PpGH9W+rYkFS8f7AILNfFqJMoWAuDk=
X-Received: by 2002:a02:1746:: with SMTP id 67mr3911965jah.103.1589314103323;
 Tue, 12 May 2020 13:08:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200512040113.277768-1-loic.yhuel@gmail.com>
In-Reply-To: <20200512040113.277768-1-loic.yhuel@gmail.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Tue, 12 May 2020 13:08:12 -0700
Message-ID: <CACdnJuv8OyQpO4achWJb2HeB8Jb6Ejq9LsG64659JSay-a9O5A@mail.gmail.com>
Subject: Re: [PATCH] tpm: check event log version before reading final events
To:     =?UTF-8?Q?Lo=C3=AFc_Yhuel?= <loic.yhuel@gmail.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Javier Martinez Canillas <javierm@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, May 11, 2020 at 9:01 PM Lo=C3=AFc Yhuel <loic.yhuel@gmail.com> wrot=
e:

> We get an event log in the SHA-1 format, which doesn't have a
> tcg_efi_specid_event_head in the first event, and there is a final events
> table which doesn't match the crypto agile format.

This seems like a firmware bug, but we definitely shouldn't fail as a resul=
t.

Reviewed-by: Matthew Garrett <mjg59@google.com>
