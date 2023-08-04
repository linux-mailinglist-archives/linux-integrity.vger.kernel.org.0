Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 870C776F6E0
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Aug 2023 03:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbjHDBXA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Aug 2023 21:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjHDBW7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Aug 2023 21:22:59 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C2E423E
        for <linux-integrity@vger.kernel.org>; Thu,  3 Aug 2023 18:22:59 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3741Cal4028127;
        Fri, 4 Aug 2023 01:22:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=EZoQ5baYBy78pGSk/DSTrKlYzfl3jQVpfJQNoavlcBM=;
 b=rewqE4bc620Oiw+mDYx1rxgA/zmXIrx0WO9IXy1S0tpuHE827166LxhuacQSQZcsOzU5
 x34hWCZi+gO5GNbUKCoAA6Jw8L+nmiiCdBChUAb4vI5hJln2y0VtW4Lqd3rKrrExh2b0
 U14vhfg0Oz3aQgg1f/+MMzbsO66fIIel1KPCZLJKTZHMYMDP6o+uTKdzXr6EvdWXF5OZ
 vZ0FRhXugDENW+k1A383hWiIaGcKV+cX5dyUElcI50ymT1Nl5gEdbMSwAijtx1du/9NI
 1Vr4lnDv39mVTE8mrsYWgUjTeONRcVYrpaBYfeWEKFJYFoGIasBO43l4nHUZ9lpo9WKC JQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s8qf4r707-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Aug 2023 01:22:39 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3741CcIJ028149;
        Fri, 4 Aug 2023 01:22:38 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s8qf4r6yx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Aug 2023 01:22:38 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 373NOjKf015780;
        Fri, 4 Aug 2023 01:22:37 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3s8kn71hew-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Aug 2023 01:22:37 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
        by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3741MaRE34406860
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Aug 2023 01:22:36 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 53CC558059;
        Fri,  4 Aug 2023 01:22:36 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 898DD58058;
        Fri,  4 Aug 2023 01:22:35 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.157.226])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Fri,  4 Aug 2023 01:22:35 +0000 (GMT)
Message-ID: <7da13140fd4ab43e797214f08bf7bca07640c238.camel@linux.ibm.com>
Subject: Re: [PATCH 4/6] ima: implement functionality to measure TPM update
 counter
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>, noodles@fb.com,
        bauermann@kolabnow.com, ebiederm@xmission.com, bhe@redhat.com,
        vgoyal@redhat.com, dyoung@redhat.com, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, kexec@lists.infradead.org,
        linux-integrity@vger.kernel.org
Cc:     code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
Date:   Thu, 03 Aug 2023 21:22:35 -0400
In-Reply-To: <b9a77076-d6ac-a1ec-5e75-ab066dfade69@linux.microsoft.com>
References: <20230801181917.8535-1-tusharsu@linux.microsoft.com>
         <20230801181917.8535-5-tusharsu@linux.microsoft.com>
         <a2d9af7f54f364da9aeaef3dc6e03b7412957c23.camel@linux.ibm.com>
         <b9a77076-d6ac-a1ec-5e75-ab066dfade69@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jaJ8LnyPfg9dn1-OxJnFtHMtbnDbuJF3
X-Proofpoint-GUID: rZO39hUoQVqgxUpGFOsyAhRV3uwuXekn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-03_24,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0
 impostorscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308040007
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2023-08-03 at 16:01 -0700, Tushar Sugandhi wrote:
> >> +    scnprintf(buf, IMA_TPM_UPDATE_CTR_BUF_SIZE, "update_counter=%u;",
> >> +                      update_counter);
> >> +
> >> +    buf_len = strlen(buf);
> >> +
> >> +    result = ima_measure_critical_data("tpm_pcr_update_counter", event_name,
> >> +                              buf, buf_len, false, NULL, 0);
> >>
> > The new record should contain everything needed to verify the
> > pcrCounter.  For example, each IMA measurement record updates the
> > pcrCounter for each TPM bank enabled.  So the number of enabled TPM
> > banks and number of IMA measurements should also be included in this
> > record.
> Agreed. That should be valuable information.
> How does the below format look like for the buf above?
> 
> version=<N>.<N>.<N>;num_enabled_pcr_banks=<N>;pcrUpdateCounter=<N>;num_ima_measurements=<N>;

Refer to comment in 5/6.

> > Perhaps include a version number as well, so that if we ever want to
> > include other information, we could.
> By version number, do you mean kernel_version, or a new version
> number specific to this record? Or something else?

This is a record version type number.  The record format shouldn't
change, but we should be prepared for it changing.  A single number
should be fine.

-- 
thanks,

Mimi

