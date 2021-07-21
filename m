Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 414633D12B0
	for <lists+linux-integrity@lfdr.de>; Wed, 21 Jul 2021 17:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbhGUPCA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 21 Jul 2021 11:02:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60235 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232939AbhGUPCA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 21 Jul 2021 11:02:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626882156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mC3YFDA+fRrmMU6CPpALtx86xAvYF4K/VPk02lU+2Pc=;
        b=X6M9/iwMPG3gFtqmdCwbGBGUvdwjTYumQ+caRelv1FClABNYBK1AENyfoGdUaOAi6fjM7/
        s6zebEBtL/gBPUOWTrA51MrjuwuFRTrtzNHfHkYjawD//Wxb8azf3+IVuJZdHOqwBmOgQO
        KT6KPNjuBNEVHhHb3BJ6iI33uzsbKVQ=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120-_m_KQjKWPtC4tKnhV8E1Hw-1; Wed, 21 Jul 2021 11:42:34 -0400
X-MC-Unique: _m_KQjKWPtC4tKnhV8E1Hw-1
Received: by mail-qv1-f70.google.com with SMTP id u8-20020a0562141c08b02902e82df307f0so1827813qvc.4
        for <linux-integrity@vger.kernel.org>; Wed, 21 Jul 2021 08:42:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mC3YFDA+fRrmMU6CPpALtx86xAvYF4K/VPk02lU+2Pc=;
        b=lQupXljXUD2RLBqRHWv2NaNQYLNBQHoc6bC6HbSwWHqM8UH7tyqsslton1d6oOTFZD
         vuKNYO8QY4AdpDmHFN/LsR5bJi5is0b/0hIY7vtPMdQbbrt2Jut5cACZBwhCO0K67VPT
         N1X5qZgn7biA2Gf8mySAruNiLSPA899aE9JEZrIxIMEASyBJVhgH3K2ginMZC3BXSuPX
         sriBtmSnHckISvY7SFntPDfO0R8JopH+L6hfDlrMT4ykEABMrzuo7XzCiQEjhhvpG/jx
         2XOPWUdSt3xkLBMW3j5+psnFVwgYbG6ZL6hyQIqrX8eYMrrzaiwF71CjeGpgR5ukgBQN
         AeGw==
X-Gm-Message-State: AOAM531UiCsXNKkeRbtqbO4HgSHqyf0gZ8KQBKorZEaNQNBZTxcCW/Oj
        j0habEuvr9DFbaPR6iJ9vh+WtUELjeeOFW3K643Ebazvy5Db/ooQaKW4n8Sl0Q7BsvcX6JfUN3Y
        JaGRDRUWkg9MrM0CKyWahHJK8ceo=
X-Received: by 2002:ac8:1249:: with SMTP id g9mr18972682qtj.292.1626882154313;
        Wed, 21 Jul 2021 08:42:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyBCUbNIq4GM1ljypiPbKNvxp5VilwRNSZpBInXM1bHvIYhD/SAhXl5O1HT4obVg4YaJLewZQ==
X-Received: by 2002:ac8:1249:: with SMTP id g9mr18972670qtj.292.1626882154100;
        Wed, 21 Jul 2021 08:42:34 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id d79sm6825042qke.45.2021.07.21.08.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 08:42:33 -0700 (PDT)
Date:   Wed, 21 Jul 2021 11:42:32 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        dm-devel@redhat.com, agk@redhat.com,
        linux-integrity@vger.kernel.org, nramas@linux.microsoft.com
Subject: Re: [PATCH 1/7] dm: measure data on table load
Message-ID: <YPhAaAyo8fKXzu5c@redhat.com>
References: <20210713004904.8808-1-tusharsu@linux.microsoft.com>
 <20210713004904.8808-2-tusharsu@linux.microsoft.com>
 <713d22788b678c612c5b18edfb8cf849af61ace5.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <713d22788b678c612c5b18edfb8cf849af61ace5.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jul 20 2021 at 10:12P -0400,
Mimi Zohar <zohar@linux.ibm.com> wrote:

> Hi Tushar, Mike, 
> 
> On Mon, 2021-07-12 at 17:48 -0700, Tushar Sugandhi wrote:
> > +struct dm_ima_device_table_metadata {
> > +       /*
> > +        * Contains data specific to the device which is common across
> > +        * all the targets in the table.e.g. name, uuid, major, minor etc.
> > +        * The values are stored in comma separated list of key1=val1,key2=val2; pairs
> > +        * delimited by a semicolon at the end of the list.
> > +        */
> > +       char *device_metadata;
> > +       unsigned int device_metadata_len;
> > +       unsigned int num_targets;
> > +
> > +       /*
> > +        * Contains the sha256 hashs of the IMA measurements of the
> > +        * target attributes key-value pairs from the active/inactive tables.
> > +        */
> 
> From past experience hard coding the hash algorithm is really not a
> good idea.
> 
> Mimi
> 
> > +       char *hash;
> > +       unsigned int hash_len;
> > +
> > +};

Hi Mimi,

The dm-ima.c code is using SHASH_DESC_ON_STACK and then storing the
more opaque result via 'hash' and 'hash_len'.

So if/when the dm-ima.c hash algorithm were to change this detail
won't change the dm_ima_device_table_metadata structure at all right?
But even if changes were needed this is purely an implementation
detail correct?  Why might users care which algorithm is used by
dm-ima to generate the hashes?

Assuming there is a valid reason for users to care about this, we can
improve this aspect as follow-on work.. so I don't consider this a
blocker for this patchset at this point.  Please clarify if you feel
it should be a blocker.

Thanks,
Mike

