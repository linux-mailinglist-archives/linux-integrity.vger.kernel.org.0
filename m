Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2859E466AB1
	for <lists+linux-integrity@lfdr.de>; Thu,  2 Dec 2021 21:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbhLBUH3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Dec 2021 15:07:29 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:16986 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234495AbhLBUH3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Dec 2021 15:07:29 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B2JkMXt018732;
        Thu, 2 Dec 2021 20:03:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=JVUESl4I0bnV568B4V73NjDum6NfFV9zYHtIUC3l7Fg=;
 b=QSscx4IAbU2pDL6CxdJxBu2UzDx+vsg6EBovEGp0up3l2X9eVKtJm13CtwWA/pdhJrRF
 RDA0HSmdYAUtpf40r6HPeAXxt8ZwzOVzTteXQcFqadZCK1JLpgAIzc+4bwS0ua2t+WRo
 nyHEuCRXSBXXQiUp3fGn9zUBbYnIWIhWhZhSGRXJrpzBRumhXGj5nrG3eR4zZB8ldJG/
 cJ3R1Ttk1CizdMNPtnmcIeJszB83vGMmTOP29/R/W4p2nwMq6Ny6C6jyYAg9FQgQhaUq
 EEhmV89aQy4ApJQaNfhiJsaKWWOqhJvz4b0PHJEwjhPyQOaXTvqNvoY368mF3n+C2xXV cg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cq4kk0a4g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Dec 2021 20:03:36 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B2JkQDR018828;
        Thu, 2 Dec 2021 20:03:35 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cq4kk0a3w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Dec 2021 20:03:35 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B2K1jnS013298;
        Thu, 2 Dec 2021 20:03:34 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma01wdc.us.ibm.com with ESMTP id 3ckcacnvup-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Dec 2021 20:03:34 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B2K3WwG33882396
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Dec 2021 20:03:32 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2DE047805E;
        Thu,  2 Dec 2021 20:03:32 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E81177805C;
        Thu,  2 Dec 2021 20:03:29 +0000 (GMT)
Received: from jarvis.int.hansenpartnership.com (unknown [9.211.96.125])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu,  2 Dec 2021 20:03:29 +0000 (GMT)
Message-ID: <4f435ce94795529c92d9ad315c5d3595a095f6c5.camel@linux.ibm.com>
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
Date:   Thu, 02 Dec 2021 15:03:28 -0500
In-Reply-To: <5a8c8801-d8ce-ab9b-3d38-25fbb4a4f6bb@linux.ibm.com>
References: <20211130160654.1418231-1-stefanb@linux.ibm.com>
         <20211130160654.1418231-9-stefanb@linux.ibm.com>
         <141ce433f026b47edb1d9a8f89e4581db253c579.camel@linux.ibm.com>
         <c3b99439-1dd6-e204-ad41-5d8bacb54d48@linux.ibm.com>
         <eeaadc76ca2da67d79c155497a73c6905b70e726.camel@linux.ibm.com>
         <05da6ebc-0cd4-753a-8589-4b1a06d198c6@linux.ibm.com>
         <39e43a4829b86b5a87bc082628cc6f45d4d8c899.camel@linux.ibm.com>
         <5a8c8801-d8ce-ab9b-3d38-25fbb4a4f6bb@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: gVSpdaETpkb3vJU3nqa1RZGymLUjVYMK
X-Proofpoint-GUID: WoqGx67ao9_ajJjGBkG5JnqO_pTbC36T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-02_13,2021-12-02_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 impostorscore=0 spamscore=0
 priorityscore=1501 adultscore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112020127
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2021-12-02 at 13:03 -0500, Stefan Berger wrote:
> On 12/2/21 12:44, James Bottomley wrote:
> > On Thu, 2021-12-02 at 11:45 -0500, Stefan Berger wrote:
> > > On 12/2/21 11:29, James Bottomley wrote:
> > > > On Thu, 2021-12-02 at 08:41 -0500, Stefan Berger wrote:
> > > > > On 12/2/21 07:46, James Bottomley wrote:
> > > > > > On Tue, 2021-11-30 at 11:06 -0500, Stefan Berger wrote:
> > > > > > > Move measurement list related variables into the
> > > > > > > ima_namespace. This way a front-end like SecurityFS can
> > > > > > > show the measurement list inside an IMA
> > > > > > > namespace.
> > > > > > > 
> > > > > > > Implement ima_free_measurements() to free a list of
> > > > > > > measurements and call it when an IMA namespace is
> > > > > > > deleted.
> > > > > > This one worries me quite a lot.  What seems to be
> > > > > > happening in this code:
> > > > > > 
> > > > > > > @@ -107,7 +100,7 @@ static int
> > > > > > > ima_add_digest_entry(struct
> > > > > > > ima_namespace *ns,
> > > > > > >            qe->entry = entry;
> > > > > > >     
> > > > > > >            INIT_LIST_HEAD(&qe->later);
> > > > > > > -       list_add_tail_rcu(&qe->later, &ima_measurements);
> > > > > > > +       list_add_tail_rcu(&qe->later, &ns-
> > > > > > > >ima_measurements);
> > > > > > >     
> > > > > > >            atomic_long_inc(&ns->ima_htable.len);
> > > > > > >            if (update_htable) {
> > > > > > > 
> > > > > > is that we now only add the measurements to the namespace
> > > > > > list, but that list is freed when the namespace
> > > > > > dies.  However, the measurement is still extended through
> > > > > > the PCRs meaning we have incomplete information for a
> > > > > > replay after the namespace dies?
> > > > > *Not at all.* The measurement list of the namespace is
> > > > > independent of the host.
> > > > > 
> > > > > The cover letter states:
> > > > I get that the host can set up a policy to log everything in
> > > > the namespace, but that wasn't my question.  My question is can
> > > > the guest set up a policy to log something that doesn't go into
> > > > the host log (because the host hasn't asked for it to be
> > > > logged) but extends a PCR anyway, thus destroying the ability
> > > > of the host to do log replay.
> > > host log goes with host TPM and vice versa
> > > 
> > > guest log goes with (optional) vTPM and vice version
> > But that's what doesn't seem to happen ... ima_pcr_extend isn't
> > virtualized and it's always called from ima_add_template_entry()
> > meaning the physical TPM is always extended even for a namespace
> > only entry.
> 
> You cannot set a measurement rule in the namespace. That is
> prevented per 9/20: ima: Only accept AUDIT rules for IMA non-
> init_ima_ns namespaces for now.

Ah, OK, so the answer is nothing ever traverses this code for the non-
root namespace, so no measurement ever get logged inside a namespace.
Got it.

James


