Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7DDCC28A
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Oct 2019 20:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbfJDSYk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 4 Oct 2019 14:24:40 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37122 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726811AbfJDSYj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 4 Oct 2019 14:24:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570213478;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pqzzV5vJFNCOdzSEIMCqALKm4Kwel64+vdB/ceB/Lkg=;
        b=Ui4/oaOCAvV0Z7KvuORzJW+qOhircYlX/FfEdWyW1lBHJZYeIEElLxyP/3lEfRkoRTbGRO
        C5bhBUinqpKxLT3jIGIgwt0A2yuhhVL+g5r9lmuBgQT6VqVxV2KxWPSqR4N5UKbIioxLc2
        05LCxE0fadaLk/1mm3yEMzTh2tZ1H8g=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-78-kqcQeAO3NAypibeV9si1bA-1; Fri, 04 Oct 2019 14:24:37 -0400
Received: by mail-io1-f71.google.com with SMTP id q18so13258532ios.8
        for <linux-integrity@vger.kernel.org>; Fri, 04 Oct 2019 11:24:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=pqzzV5vJFNCOdzSEIMCqALKm4Kwel64+vdB/ceB/Lkg=;
        b=MTXtdudKSxNskMfaSUZNDPstwy85hDAzmMNYE2guGKCDyzMA0yvA0k0LJmMLl2Cvo7
         mgpaCK/a6Mtp2QI1vmIl23ks6N9JCrEaX4zHHGPSSbxrHeqiTHgIJwUYespQB3kj9u9K
         63kHKaA1S4ozKniB54SMLHcxNVH97mATL+5BLZtxOjMtSw2WSt+6lpWZLVlC6ZffXo/I
         czoRw9iDEyd28VKi9lfjEu2JbsKW7UKUcxGqs5v9fOcvJsV8E6J4k14IG1yHMSdrL+1t
         b6XiIn9x45QU9viz1/JRfaXswq9PeExcuzzborKF90hTETpCUGnzjxiCqG8AyfasNV2b
         WNLw==
X-Gm-Message-State: APjAAAXYFPGfX9iD5K19mHL68rj8gMlj7fGQTxdBi2V5GKjAtoBUeIn/
        SMQRmgZ1epfuyl1NkFov9+P4c5KC8XpxT8C/g2xWntIl4UAKAtQyMiy2quDMvx9Lvkw+koVF4rs
        nMse8Y7UjQ843seHdJpreWb0Wttz8
X-Received: by 2002:a05:6638:6b2:: with SMTP id d18mr836990jad.61.1570213476839;
        Fri, 04 Oct 2019 11:24:36 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyI8fLd6aXkKdblFKVEIM81Q5egEhQo3siRanbIZDP12JwkuVCLyPar9tLUnjAhEGDqfiNp/A==
X-Received: by 2002:a05:6638:6b2:: with SMTP id d18mr836947jad.61.1570213476540;
        Fri, 04 Oct 2019 11:24:36 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id m9sm2479604ion.65.2019.10.04.11.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 11:24:35 -0700 (PDT)
Date:   Fri, 4 Oct 2019 11:24:34 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] tpm: Detach page allocation from tpm_buf
Message-ID: <20191004182434.tjwtfjzvamomybhr@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: James Bottomley <James.Bottomley@HansenPartnership.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org, Sumit Garg <sumit.garg@linaro.org>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20191003185103.26347-1-jarkko.sakkinen@linux.intel.com>
 <20191003185103.26347-3-jarkko.sakkinen@linux.intel.com>
 <1570207062.3563.17.camel@HansenPartnership.com>
 <1570210647.5046.78.camel@linux.ibm.com>
 <1570210902.3563.19.camel@HansenPartnership.com>
MIME-Version: 1.0
In-Reply-To: <1570210902.3563.19.camel@HansenPartnership.com>
User-Agent: NeoMutt/20180716
X-MC-Unique: kqcQeAO3NAypibeV9si1bA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri Oct 04 19, James Bottomley wrote:
>On Fri, 2019-10-04 at 13:37 -0400, Mimi Zohar wrote:
>> On Fri, 2019-10-04 at 09:37 -0700, James Bottomley wrote:
>> > On Thu, 2019-10-03 at 21:51 +0300, Jarkko Sakkinen wrote:
>> > > As has been seen recently, binding the buffer allocation and
>> > > tpm_buf
>> > > together is sometimes far from optimal.
>> >
>> > Can you elaborate on this a bit more?  I must have missed the
>> > discussion.
>>
>> Refer to e13cd21ffd50 ("tpm: Wrap the buffer from the caller to
>> tpm_buf in tpm_send()") for the details.
>
>Yes, I get that, but to my mind that calls for moving the
>tpm_init/destroy_buf into the callers of tpm_send (which, for the most
>part, already exist), which means there's no need to separate the buf
>and data lifetimes.
>
>James
>

Sumit has been working on a patchset that does this.  His patchset
converts both the asymmetric keys and trusted keys code to using the
tpm_buf manipulation functions.

