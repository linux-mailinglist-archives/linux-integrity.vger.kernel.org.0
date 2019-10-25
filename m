Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D992FE4EB3
	for <lists+linux-integrity@lfdr.de>; Fri, 25 Oct 2019 16:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725919AbfJYON5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 25 Oct 2019 10:13:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32174 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727003AbfJYON4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 25 Oct 2019 10:13:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572012830;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iKhhUZoR3ETcndZCkdmFNE8ChoQ3VU6czGoP+SADhxw=;
        b=HOjdqZkHgjBHj+mpvGp2bY5v0937PC63WPQfW//+j8t/RfgUsmuE+L3lOJu0HSdLwbzHtr
        QjolhGLw30FNwBJaXBSI8R1frv6Xxio66RqJKbMXL/VjPYCzrmQprp90nIKJsmtTVyDakX
        NVEkBRJ4EKLeJoUEHix80oVc+qWxPlE=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-bWo64EzdOnmnTFqOyPlPTw-1; Fri, 25 Oct 2019 10:13:49 -0400
Received: by mail-pf1-f199.google.com with SMTP id r19so2000717pfh.7
        for <linux-integrity@vger.kernel.org>; Fri, 25 Oct 2019 07:13:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=X+e8SRli7RIXuNIpLGcbbLLRwOMtP8b1dDWnVykEWd8=;
        b=f0njXOGElzK+oknu8IQN97HpW5FWSnYXA6cn7GE1ijNclQP07Gu0f+woor9gR297cn
         OZz/bgJ+xCw4aYX020AJ5UDvYLBsbcZHxvSaBRJYzqnbBgnT2GoBIV1rz46oV9CuCMxO
         NNX3ROfNIvy+uLYe9qGwcsLIl5wpx0dkEaKengaVFixbbFoYsFWFIHBMo95eVUsIaue4
         AcK2UZxYTmFSf0wppxLA9cx99k68RNbxrmov8ONGo320oziw4aZxhbUrFM7+s72ba3BL
         40xpQfn3qX4c4li9T9mU6tG/0/sz/ezDpTm3j5vhtNrsa8dNLsMaxSmcr6XOl9cOltcM
         sBag==
X-Gm-Message-State: APjAAAWg1/Emf43c5RMfKq0CHsr7XCIn17VhpDLHeOq5gdUb3nIzUAQr
        LabJi0g7QegrM2htu/2b2p+wAkEfyseb6sRw3ozwgRP6jXliyTYokrBH6t+aYzEmUsHt/xM1W7X
        /YPpiz3k+ks+tsf5pIJvQISBYr/Ii
X-Received: by 2002:a17:902:930b:: with SMTP id bc11mr4112125plb.284.1572012828060;
        Fri, 25 Oct 2019 07:13:48 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw9k9KnbOJwB4/FRHSgZ+Ocoy9VruYqrc0rVKQ5nE7UqMIMmehiCscqeRU+ui7pdmzchKD1EA==
X-Received: by 2002:a17:902:930b:: with SMTP id bc11mr4112101plb.284.1572012827821;
        Fri, 25 Oct 2019 07:13:47 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id 27sm2661444pgx.23.2019.10.25.07.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 07:13:46 -0700 (PDT)
Date:   Fri, 25 Oct 2019 07:13:45 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Nayna <nayna@linux.vnet.ibm.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        ltp@lists.linux.it,
        Piotr =?utf-8?B?S3LDs2w=?= <piotr.krol@3mdeb.com>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [LTP] [PATCH] ima: skip verifying TPM 2.0 PCR values
Message-ID: <20191025141345.46ifshskk2vpxi2t@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
References: <1558041162.3971.2.camel@linux.ibm.com>
 <fccc3abd-f3ce-fdb1-55d7-c18ce116446c@linux.vnet.ibm.com>
 <20190517150456.GA11796@dell5510>
 <20191024121848.GA5908@dell5510>
 <20191024172023.GA7948@linux.intel.com>
 <20191024213842.c6cl4tlnsi56pgcy@cantor>
 <1571964420.5173.12.camel@linux.ibm.com>
 <20191025021159.dt7ifgnebnke6ca7@cantor>
 <20191025085617.GA13329@x230>
MIME-Version: 1.0
In-Reply-To: <20191025085617.GA13329@x230>
User-Agent: NeoMutt/20180716
X-MC-Unique: bWo64EzdOnmnTFqOyPlPTw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri Oct 25 19, Petr Vorel wrote:
>Hi,
>
>> /sys/kernel/security/tpmX/major_version (on fedora and rhel at least, is=
 it elsewhere on other distros?)
>
>> versus
>
>> /sys/class/tpm/tpmX/major_version
>
>Is it more HW related (/sys/class/tpm/tpmX) or LSM related
>(/sys/kernel/security/tpmX)?
>I guess /sys/kernel/security/tpmX might be better.
>

I think it is HW related since it is describing the
TCG version that the chip implements.

>Thanks for implementing this, I'll try to test it soon.
>
>Kind regards,
>Petr

