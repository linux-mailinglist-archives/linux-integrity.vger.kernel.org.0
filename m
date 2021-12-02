Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 842E9466853
	for <lists+linux-integrity@lfdr.de>; Thu,  2 Dec 2021 17:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237007AbhLBQdk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Dec 2021 11:33:40 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56427 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230060AbhLBQdj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Dec 2021 11:33:39 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B2EddoT030799;
        Thu, 2 Dec 2021 16:29:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=+5dictTnW7menonE8Uu7D4Mh9Iqfr1cClZiq7J6QGUc=;
 b=Z361jl1gz7loVU7mCa7eK/nZTd5udEMKmjmaCHAk2cRXYnyefZ+7dJYsp9anzGMBdVCc
 eP2dZYZ4kYyly7Ez60VomgQdutJVRmaOJTrADvsw4DY9sSuTlB25lAJAaygdRpeINEht
 EDmhAV0meWxh1Tw650kPlogN07JkmkW+xM93NbVovhtl0S4BvvU4lyyGR5q4/8mhKesk
 aMsWSu6JCmTRh57aE4OcqM+F65xIPUNBYZ5aEudd4hkY/iHzF8vn+0XFcoHXgQuw9swX
 QxJHxCIE1ojtfpU6bF9UaHPR3Cjy/cjBUdDdnQA8EZuoThhn2ECeTMLUM2fmhGGQnAnd JQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cpys2k9mq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Dec 2021 16:29:55 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B2FiKOZ016427;
        Thu, 2 Dec 2021 16:29:55 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cpys2k9m7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Dec 2021 16:29:55 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B2GT7f3028713;
        Thu, 2 Dec 2021 16:29:54 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma02wdc.us.ibm.com with ESMTP id 3ckcacsx7j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Dec 2021 16:29:54 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B2GTqLx28050078
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Dec 2021 16:29:52 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5DA2178098;
        Thu,  2 Dec 2021 16:29:52 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EFC5478063;
        Thu,  2 Dec 2021 16:29:47 +0000 (GMT)
Received: from jarvis.int.hansenpartnership.com (unknown [9.211.96.125])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu,  2 Dec 2021 16:29:47 +0000 (GMT)
Message-ID: <eeaadc76ca2da67d79c155497a73c6905b70e726.camel@linux.ibm.com>
Subject: Re: [RFC 08/20] ima: Move measurement list related variables into
 ima_namespace
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, serge@hallyn.com,
        christian.brauner@ubuntu.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
Date:   Thu, 02 Dec 2021 11:29:46 -0500
In-Reply-To: <c3b99439-1dd6-e204-ad41-5d8bacb54d48@linux.ibm.com>
References: <20211130160654.1418231-1-stefanb@linux.ibm.com>
         <20211130160654.1418231-9-stefanb@linux.ibm.com>
         <141ce433f026b47edb1d9a8f89e4581db253c579.camel@linux.ibm.com>
         <c3b99439-1dd6-e204-ad41-5d8bacb54d48@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TYJca4kMZ2T-YEQV5jG84fVHlYog7MsA
X-Proofpoint-GUID: kAPnGdCaN722DRo6Nft-lRHP8cW2aYl9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-02_10,2021-12-02_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 bulkscore=0 priorityscore=1501 adultscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112020106
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2021-12-02 at 08:41 -0500, Stefan Berger wrote:
> On 12/2/21 07:46, James Bottomley wrote:
> > On Tue, 2021-11-30 at 11:06 -0500, Stefan Berger wrote:
> > > Move measurement list related variables into the ima_namespace.
> > > This
> > > way a
> > > front-end like SecurityFS can show the measurement list inside an
> > > IMA
> > > namespace.
> > > 
> > > Implement ima_free_measurements() to free a list of measurements
> > > and call it when an IMA namespace is deleted.
> > This one worries me quite a lot.  What seems to be happening in
> > this
> > code:
> > 
> > > @@ -107,7 +100,7 @@ static int ima_add_digest_entry(struct
> > > ima_namespace *ns,
> > >          qe->entry = entry;
> > >   
> > >          INIT_LIST_HEAD(&qe->later);
> > > -       list_add_tail_rcu(&qe->later, &ima_measurements);
> > > +       list_add_tail_rcu(&qe->later, &ns->ima_measurements);
> > >   
> > >          atomic_long_inc(&ns->ima_htable.len);
> > >          if (update_htable) {
> > > 
> > is that we now only add the measurements to the namespace list, but
> > that list is freed when the namespace dies.  However, the
> > measurement
> > is still extended through the PCRs meaning we have incomplete
> > information for a replay after the namespace dies?
> 
> *Not at all.* The measurement list of the namespace is independent
> of 
> the host.
> 
> The cover letter states:

I get that the host can set up a policy to log everything in the
namespace, but that wasn't my question.  My question is can the guest
set up a policy to log something that doesn't go into the host log
(because the host hasn't asked for it to be logged) but extends a PCR
anyway, thus destroying the ability of the host to do log replay.

James


