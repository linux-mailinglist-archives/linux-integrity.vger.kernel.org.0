Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC1F30AAE9
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Feb 2021 16:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbhBAPR6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 1 Feb 2021 10:17:58 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39472 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229696AbhBAO46 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 1 Feb 2021 09:56:58 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 111Egd34047211;
        Mon, 1 Feb 2021 09:54:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=Eco68iy3KXQeX5Y/LC/T9Vir6Vx7EB+4u8SHI3aJZHQ=;
 b=NTBuo+1CI0zvbH4KTihNd622laVsQgzLx00UKb3CsGbIm82bWscCOvyif3NP7Ak9HKhN
 jEMUNyn5QwIiEsRYHcfz6b7nrHFK8W/Dz8BOpFSNk6yIG2u9/t3U0B0UCugZ6Da6fevo
 sv0S3KRbdFEdpr4b61xWwKwTE1Lpkw67fniLmV9UEZEQxP4FavF0T0a9cJOmN3BWsBFZ
 hM8tj0Js/NoMP9l82KXNzr8Bt+iPaB8VGRH8AzFSgXJoKMJrl9O3iQmBIVSe3XXnf/B0
 0TQGeFiF2dUpoDSzGEn3bFkNkqufGcbp53h/BBH+fFstiqDfEU+artzRft0OnnmLybRB aQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36ekn20dyu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Feb 2021 09:54:51 -0500
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 111EiiFF057240;
        Mon, 1 Feb 2021 09:54:51 -0500
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36ekn20dy1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Feb 2021 09:54:50 -0500
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 111Esnf2028698;
        Mon, 1 Feb 2021 14:54:49 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma01fra.de.ibm.com with ESMTP id 36cy37s0g6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Feb 2021 14:54:49 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 111Eskbq40436012
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Feb 2021 14:54:46 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BAA8142042;
        Mon,  1 Feb 2021 14:54:46 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7BC4B42041;
        Mon,  1 Feb 2021 14:54:44 +0000 (GMT)
Received: from sig-9-65-218-191.ibm.com (unknown [9.65.218.191])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  1 Feb 2021 14:54:44 +0000 (GMT)
Message-ID: <58935b00f65e389e9ae3da2425d06bd88d280e43.camel@linux.ibm.com>
Subject: Re: [PATCH v5 2/4] x509: Detect sm2 keys by their parameters OID
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        David Howells <dhowells@redhat.com>
Cc:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, patrick@puiterwijk.org,
        linux-integrity@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Date:   Mon, 01 Feb 2021 09:54:43 -0500
In-Reply-To: <71a77d10-e645-194f-5073-ebf180a8d70e@linux.ibm.com>
References: <20210129150355.850093-3-stefanb@linux.vnet.ibm.com>
         <20210129150355.850093-1-stefanb@linux.vnet.ibm.com>
         <4162801.1612185801@warthog.procyon.org.uk>
         <71a77d10-e645-194f-5073-ebf180a8d70e@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-01_05:2021-01-29,2021-02-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102010073
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2021-02-01 at 09:35 -0500, Stefan Berger wrote:
> On 2/1/21 8:23 AM, David Howells wrote:
> > Stefan Berger <stefanb@linux.vnet.ibm.com> wrote:
> >
> >> From: Stefan Berger <stefanb@linux.ibm.com>
> >>
> >> Detect whether a key is an sm2 type of key by its OID in the parameters
> >> array rather than assuming that everything under OID_id_ecPublicKey
> >> is sm2, which is not the case.
> >>
> >> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> >> Cc: David Howells <dhowells@redhat.com>
> >> Cc: keyrings@vger.kernel.org
> > I presume these cc's are intentionally not on the first patch or the cover (if
> > there is one)?
> 
> No, this is not intentional. I guess this is a case of wrong use of cc: 
> versus mailing lists - my bad. I posted the whole series to 
> linux-crypto, linux-integrity, keyrings and lkml.
> 
> V6 is at least visible here now:
> 
> - https://lkml.org/lkml/2021/1/31/323
> 
> - https://marc.info/?l=linux-crypto-vger&m=161213604618722&w=2
> 
> - 
> https://lore.kernel.org/linux-integrity/20210131233301.1301787-1-stefanb@linux.ibm.com/T/#mbc9fae5facb4178f64c1145e2654258c0af8fa96
> 
> - https://marc.info/?l=linux-keyrings&m=161213608818735&w=2
> 
> 
> 
> >
> > Do you have a branch you want me to pull or did you want me to take just
> > patches 2-4?
> 
> Please take it from the mailing list. If there are requests for more 
> changes on the crypto level, I will send another series. I personally am 
> waiting for some sort of verdict on the crypto level...

The entire patch set should be upstreamed as a single patch set, after
having each of the maintainer's Ack it.  In addition, the v6 version is
missing some Reviewed-by tags.  (Stefan will re-post a v7 patch set.)

David, I don't have problem with this patch set being upstreamed via
the keys subsystem, assuming it's been tested.

thanks,

Mimi

