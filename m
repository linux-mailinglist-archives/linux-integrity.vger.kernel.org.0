Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7BF77C332
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Aug 2023 00:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbjHNWCw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 14 Aug 2023 18:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233169AbjHNWCu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 Aug 2023 18:02:50 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7A810F0;
        Mon, 14 Aug 2023 15:02:49 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37EM2SHx018871;
        Mon, 14 Aug 2023 22:02:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=FpIoN8YUDy/37QmvnUB3eIyTNRsXSQVZQhIRZ1O8vdM=;
 b=iE7qvxlPBDojCpIChCLGoN11AwoFOto1+T55iVSOR1IgdqVfDdtl5yXkC/uW+kiUy5ti
 bXGJqHhZ1AIvDSWo5lY55DvzooMwwgxdjvD1r5YPEuS75kX18n0/i9r/4nlYsh/RJV/m
 pJmw+5k5LK+I0BvCwbEfuQE+HkJXhlZbXblsnVa8YvMT2b4ik9tA+veCLIJzZtCcL7eY
 sWOCab1aCdJZbKqiTzMAHOGrBwZrsd0C5StybGwLd5+zcpD+LQTU7mX1DQ2/gcKGWvc5
 H6B4nHlFD8Exn0w8QMeo7TKg6gol4HHzhJMykbvHJUqxkcR3jBXgrXxeEGPRitXupsgM Og== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sfvq4801f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 22:02:27 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37EM2Qt8018846;
        Mon, 14 Aug 2023 22:02:27 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sfvq48016-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 22:02:26 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37EKULJt001107;
        Mon, 14 Aug 2023 22:02:26 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3semsy0af6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 22:02:26 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
        by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37EM2PMk66847068
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Aug 2023 22:02:25 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0A81F58059;
        Mon, 14 Aug 2023 22:02:25 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8535F5804B;
        Mon, 14 Aug 2023 22:02:23 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.145.19])
        by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 14 Aug 2023 22:02:23 +0000 (GMT)
Message-ID: <0e1511e8819b24ab8a34a7b15821f06eff688f29.camel@linux.ibm.com>
Subject: Re: [RFC] IMA Log Snapshotting Design Proposal
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Sush Shringarputale <sushring@linux.microsoft.com>,
        linux-integrity@vger.kernel.org, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, kgold@linux.ibm.com,
        bhe@redhat.com, vgoyal@redhat.com, dyoung@redhat.com,
        kexec@lists.infradead.org, jmorris@namei.org,
        Paul Moore <paul@paul-moore.com>, serge@hallyn.com
Cc:     code@tyhicks.com, nramas@linux.microsoft.com,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        linux-security-module@vger.kernel.org
Date:   Mon, 14 Aug 2023 18:02:23 -0400
In-Reply-To: <bf794136-703a-0d33-e245-7e723007b5c0@linux.microsoft.com>
References: <c5737141-7827-1c83-ab38-0119dcfea485@linux.microsoft.com>
         <277db5491460d5fd607785f2bcc733de39022a35.camel@linux.ibm.com>
         <bf794136-703a-0d33-e245-7e723007b5c0@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6baQrZRHoxmXqAZcmAVpDSkAA5M3VbwR
X-Proofpoint-GUID: Sj7FcZiqreEfeid5Qv3WlRMcISm3L49a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_18,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=885 adultscore=0 clxscore=1015
 mlxscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308140199
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2023-08-14 at 14:42 -0700, Sush Shringarputale wrote:
> > This design seems overly complex and requires synchronization between
> > the "snapshot" record and exporting the records from the measurement
> > list.  None of this would be necessary if the measurements were copied
> > from kernel memory to a backing file (e.g. tmpfs), as described in [1].
> >
> > What is the real problem - kernel memory pressure, memory pressure in
> > general, or disk space?  Is the intention to remove or offload the
> > exported measurements?

> The main concern is the memory pressure on both the kernel and the 
> attestation client
> when it sends the request.  The concern you bring up is valid and we are 
> working on
> creating a prototype.  There is no intention to remove the exported 
> measurements.

Glad to hear that you're not intending to remove the exported
measurements.

Defining and including a new record in the measurement list measurement
is fine, if it helps with attestation and doesn't require pausing the
measurements.

-- 
thanks,

Mimi

