Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4835085E7
	for <lists+linux-integrity@lfdr.de>; Wed, 20 Apr 2022 12:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351722AbiDTKcG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 20 Apr 2022 06:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351643AbiDTKcC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 20 Apr 2022 06:32:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 88FC63F8A5
        for <linux-integrity@vger.kernel.org>; Wed, 20 Apr 2022 03:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650450556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KIJu0PnDJV4/uO0UdPgu/58WGciQu1suUPJ1SFUvK60=;
        b=SnlGrCBkz2LoFJrUqXW2FMLqIFIxk4/eLOUdVnzDsCU0+ANu41vvqpk3j09OJUvIWqUoQ2
        7sghbv9sM9TU+GljW+u/SrQ9sWjnlISVaenT+FaPNNAVt+EtkDyxKMltec20lmNZETEGSd
        o5DsHvz7dD+olW01+yZnPcM/i2B3vY4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-441-5Q0XG3XRM2uJXHWtLXv0tg-1; Wed, 20 Apr 2022 06:29:12 -0400
X-MC-Unique: 5Q0XG3XRM2uJXHWtLXv0tg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 83F2338149C1;
        Wed, 20 Apr 2022 10:29:11 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E39654022C4;
        Wed, 20 Apr 2022 10:29:08 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210312171232.2681989-4-mic@digikod.net>
References: <20210312171232.2681989-4-mic@digikod.net> <20210312171232.2681989-1-mic@digikod.net>
To:     =?us-ascii?Q?=3D=3FUTF-8=3Fq=3FMicka=3DC3=3DABl=3D20Sala=3DC3=3DBCn=3F?=
         =?us-ascii?Q?=3D?= <mic@digikod.net>
Cc:     dhowells@redhat.com, David Woodhouse <dwmw2@infradead.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        James Morris <jmorris@namei.org>,
        =?us-ascii?Q?=3D=3FUTF-8=3Fq=3FMicka=3DC3=3DABl?=
         =?us-ascii?Q?=3D20Sala=3DC3=3DBCn=3F=3D?= 
        <mic@linux.microsoft.com>, Mimi Zohar <zohar@linux.ibm.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v7 3/5] certs: Make blacklist_vet_description() more strict
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 20 Apr 2022 11:29:08 +0100
Message-ID: <648218.1650450548@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> wrote:

> +	/* The following algorithm only works if prefix lengths match. */
> +	BUILD_BUG_ON(sizeof(tbs_prefix) !=3D sizeof(bin_prefix));
> +	prefix_len =3D sizeof(tbs_prefix) - 1;
> +	for (i =3D 0; *desc; desc++, i++) {
> +		if (*desc =3D=3D ':') {
> +			if (tbs_step =3D=3D prefix_len)
> +				goto found_colon;
> +			if (bin_step =3D=3D prefix_len)
> +				goto found_colon;
> +			return -EINVAL;
> +		}
> +		if (i >=3D prefix_len)
> +			return -EINVAL;
> +		if (*desc =3D=3D tbs_prefix[i])
> +			tbs_step++;
> +		if (*desc =3D=3D bin_prefix[i])
> +			bin_step++;
> +	}

I wonder if:

	static const char tbs_prefix[] =3D "tbs:";
	static const char bin_prefix[] =3D "bin:";

	if (strncmp(desc, tbs_prefix, sizeof(tbs_prefix) - 1) =3D=3D 0 ||
	    strncmp(desc, bin_prefix, sizeof(bin_prefix) - 1) =3D=3D 0)
		goto found_colon;

might be better.

David

