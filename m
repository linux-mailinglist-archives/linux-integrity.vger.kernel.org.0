Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA014C71F1
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Feb 2022 17:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237795AbiB1Qtc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 28 Feb 2022 11:49:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237790AbiB1Qtc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 28 Feb 2022 11:49:32 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1696C23BC4;
        Mon, 28 Feb 2022 08:48:53 -0800 (PST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21SG8Y43024567;
        Mon, 28 Feb 2022 16:48:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=CTDN8RZUPUuP8F+u+9VEaIHWUJd1d/j/SNjzUzHMsL0=;
 b=qITNstVxkqf0oZQv+I0q/cOEGAQJ1X//k4iU46EaRRWuYjSACMj9cDV2MLVzuOJlAHqZ
 as7wAQqm8fXNl95IUsJIIc0sIN2LgogUANyHOXeN55odEg/Q08niQOAw7P64i/MHpVZR
 G66D5h8sEFHZ3BRK0D7VYTx6PaB2l4dwUU+GITeqz3eL4EokQoVp9P1uvIjMP8N7yRJA
 M6MHrR01Ho/jQ7xlve4AvS1bjur2TP3jA/vA/BVXsPb5lBkwNF78PndobNRUftWr9IY4
 liA6wLrQPXzgrllaW36TEMIninMNy3JODjBuK+KPR+oxdE0YZL8Dymw16BcgFaFix0LO jw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3eh0tq2cuh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Feb 2022 16:48:40 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21SG9YNE026749;
        Mon, 28 Feb 2022 16:48:39 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3eh0tq2cu3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Feb 2022 16:48:39 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21SGlL6h012770;
        Mon, 28 Feb 2022 16:48:38 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 3egbj1442b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Feb 2022 16:48:37 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21SGmZaf52298016
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Feb 2022 16:48:35 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7DCD311C04C;
        Mon, 28 Feb 2022 16:48:35 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1691811C052;
        Mon, 28 Feb 2022 16:48:34 +0000 (GMT)
Received: from sig-9-65-90-138.ibm.com (unknown [9.65.90.138])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 28 Feb 2022 16:48:33 +0000 (GMT)
Message-ID: <cacde31235f08eeec698c63025a0eef81e10fe71.camel@linux.ibm.com>
Subject: Re: [PATCH 2/2] integrity: double check iint_cache was initialized
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     Casey Schaufler <casey@schaufler-ca.com>, dvyukov@google.com,
        ebiggers@kernel.org, jmorris@namei.org, keescook@chromium.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com
Date:   Mon, 28 Feb 2022 11:48:33 -0500
In-Reply-To: <YhzRvhsOPxrKHzq9@pevik>
References: <20210322154207.6802-2-zohar@linux.ibm.com>
         <20220224142025.2587-1-pvorel@suse.cz>
         <418628ea-f524-05a1-8bfc-a688fa2d625d@schaufler-ca.com>
         <YhfDhYQYZTU0clAf@pevik>
         <9405bcfc-78bd-8e7f-41d4-b919221f73e4@schaufler-ca.com>
         <c4842493db13fd6f05eda54c1ef4c94e9d687850.camel@linux.ibm.com>
         <YhzRvhsOPxrKHzq9@pevik>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QHE7bNUj7o1HHzUF2JUErdToGUpWyC_p
X-Proofpoint-GUID: Ahd4gYdJDBnigI7MtH2YBbiq5XUX9GfC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-02-28_07,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=955
 bulkscore=0 clxscore=1011 adultscore=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 impostorscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202280087
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2022-02-28 at 14:44 +0100, Petr Vorel wrote:
> Hi Mimi, all,
> 
> > Hi Petr, Casey,
> 
> > On Thu, 2022-02-24 at 10:51 -0800, Casey Schaufler wrote:
> > > On 2/24/2022 9:42 AM, Petr Vorel wrote:
> 
> > > It was always my expectation, which appears to have been poorly
> > > communicated, that "making integrity an LSM" meant using the LSM
> > > hook infrastructure. Just adding "integrity" to lsm= doesn't make
> > > it an LSM to my mind.
> 
> > Agreed.  The actual commit that introduced the change was 3d6e5f6dcf65
> > ("LSM: Convert security_initcall() into DEFINE_LSM()").
> I wonder whether we can improve things now.

I'm not sure it is possible to revert the change.  Perhaps the simplest
solution would be to move integrity off the security hook.  It just
needs to be initialized before EVM and IMA.

thanks,

Mimi

